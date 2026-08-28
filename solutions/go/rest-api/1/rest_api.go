package restapi

import "slices"

// Define the Rest API interface. You should not modify the code in this block.

type User struct {
	Name    string
	Owes    map[string]float64
	OwedBy  map[string]float64
	Balance float64
}

type GetUsersRequest struct {
	Users []string
}

type GetUsersResponse struct {
	Users []User
}

type AddUserRequest struct {
	User string
}

type AddUserResponse struct {
	User User
}

type AddIouRequest struct {
	Lender   string
	Borrower string
	Amount   float64
}

type AddIouResponse struct {
	Users []User
}

type RestApi interface {
	GetUsers(GetUsersRequest) GetUsersResponse
	AddUser(AddUserRequest) AddUserResponse
	AddIou(AddIouRequest) AddIouResponse
}

// Your code goes below here. Implement the RestApi interface.

type Api struct {
	users []User
}

func NewApi(database []User) RestApi {
	return &Api{users: database}
}

func (a *Api) GetUsers(req GetUsersRequest) GetUsersResponse {
	if len(req.Users) == 0 {
		return GetUsersResponse{Users: a.users}
	}

	requested := map[string]bool{}
	for _, name := range req.Users {
		requested[name] = true
	}

	users := make([]User, 0, len(req.Users))
	for _, user := range a.users {
		if requested[user.Name] {
			users = append(users, user)
		}
	}

	return GetUsersResponse{Users: users}
}

func (a *Api) AddUser(req AddUserRequest) AddUserResponse {
	user := User{
		Name:    req.User,
		Owes:    map[string]float64{},
		OwedBy:  map[string]float64{},
		Balance: 0,
	}
	a.users = append(a.users, user)
	return AddUserResponse{User: user}
}

func (a *Api) getUser(name string) *User {
	for i := range a.users {
		if a.users[i].Name == name {
			return &a.users[i]
		}
	}
	return nil
}

func sortedUsers(users []User) []User {
	slices.SortFunc(users, func(a, b User) int {
		if a.Name < b.Name {
			return -1
		}
		if a.Name > b.Name {
			return 1
		}
		return 0
	})
	return users
}

func (a *Api) AddIou(req AddIouRequest) AddIouResponse {
	lender := a.getUser(req.Lender)
	borrower := a.getUser(req.Borrower)
	amount := req.Amount

	if lender.Owes[borrower.Name] > 0 {
		owedAmount := lender.Owes[borrower.Name]

		if owedAmount > amount {
			lender.Owes[borrower.Name] -= amount
			lender.Balance += amount

			borrower.OwedBy[lender.Name] -= amount
			borrower.Balance -= amount

			return AddIouResponse{Users: sortedUsers([]User{*lender, *borrower})}
		}

		if owedAmount < amount {
			delete(lender.Owes, borrower.Name)
			lender.Balance += owedAmount

			delete(borrower.OwedBy, lender.Name)
			borrower.Balance -= owedAmount

			amount -= owedAmount
		} else {
			delete(lender.Owes, borrower.Name)
			lender.Balance += owedAmount

			delete(borrower.OwedBy, lender.Name)
			borrower.Balance -= owedAmount

			return AddIouResponse{Users: sortedUsers([]User{*lender, *borrower})}
		}
	}

	lender.OwedBy[borrower.Name] += amount
	lender.Balance += amount

	borrower.Owes[lender.Name] += amount
	borrower.Balance -= amount

	return AddIouResponse{Users: sortedUsers([]User{*lender, *borrower})}
}