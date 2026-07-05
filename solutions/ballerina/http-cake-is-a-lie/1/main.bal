import ballerina/http;
import ballerina/random;
import ballerina/mime;

configurable int port = 8080;

enum CakeKind {
    BUTTER_CAKE = "Butter Cake",
    CHOCOLATE_CAKE = "Chocolate Cake",
    TRES_LECHES = "Tres Leches"
}

const map<int> MENU = {
    "Butter Cake": 15,
    "Chocolate Cake": 20,
    "Tres Leches": 25
};

enum OrderStatus {
    PENDING = "pending",
    IN_PROGRESS = "in progress",
    COMPLETED = "completed"
}

type OrderDetail record {|
    CakeKind item;
    int quantity;
|};

type Order record {|
    string username;
    OrderDetail[] order_items;
|};

type OrderUpdate record {|
    OrderDetail[] order_items;
|};

map<Order> orders = {};
map<OrderStatus> orderStatus = {};

service on new http:Listener(port) {
    resource function get menu() returns MENU => MENU;
    resource function post 'order(@http:Payload Order & readonly newOrder) returns http:Created|http:BadRequest|error {
        string order_id = check generateOrderId();
        var total = computeSum(newOrder.order_items);
        if !(total is int) {
            return total;
        }
        if newOrder.username == "" {
            return <http:BadRequest>{};
        }
        orders[order_id] = check newOrder.cloneWithType(Order);
        orderStatus[order_id] = PENDING;
        return <http:Created>{
            body: {
                order_id,
                total
            },
            mediaType: mime:APPLICATION_JSON
        };
    }
    resource function get 'order/[string orderId]() returns http:Ok|http:NotFound {
        var status = orderStatus[orderId];
        if status is () {
            return <http:NotFound>{};
        }
        return <http:Ok>{
            body: {
                order_id: orderId,
                status
            },
            mediaType: mime:APPLICATION_JSON
        };
    }
    resource function put 'order/[string orderId](@http:Payload OrderUpdate & readonly updatedOrder) returns http:Ok|http:BadRequest|http:Forbidden|http:NotFound {
        var status = orderStatus[orderId];
        if status is () {
            return <http:NotFound>{};
        }
        if status != PENDING {
            return <http:Forbidden>{};
        }
        var total = computeSum(updatedOrder.order_items);
        if !(total is int) {
            return total;
        }
        orders[orderId].order_items = updatedOrder.order_items;
        return <http:Ok>{
            body: {
                order_id: orderId,
                total
            },
            mediaType: mime:APPLICATION_JSON
        };
    }

    resource function delete 'order/[string orderId]() returns http:Ok|http:Forbidden|http:NotFound {
        var status = orderStatus[orderId];
        if status is () {
            return <http:NotFound>{};
        }
        if status != PENDING {
            return <http:Forbidden>{};
        }
        var _ = orderStatus.remove(orderId);
        var _ = orders.remove(orderId);
        return <http:Ok>{};
    }
}

function generateOrderId() returns string|error {
    int id = check random:createIntInRange(0, 1000);
    if !(orders[id.toString()] is ()) {
        return generateOrderId();
    }
    return id.toString();
}

function computeSum(OrderDetail[] items) returns int|(http:BadRequest & readonly) {
    map<int> quantityPerCake = {};

    foreach var cake in items {
        if !(quantityPerCake[cake.item] is ()) {
            return {};
        } else {
            quantityPerCake[cake.item] = cake.quantity;
        }
    }

    int total = 0;
    if quantityPerCake.length() == 0 {
        return {};
    }

    foreach string cake in quantityPerCake.keys() {
        int? price = MENU[cake];
        int? quantity = quantityPerCake[cake];
        if quantity < 1 {
            return {};
        }
        if !(price is () || quantity is ()) {
            total += price * quantity;
        }
    }
    return total;
}