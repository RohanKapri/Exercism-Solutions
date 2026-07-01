#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H
#include <memory>
namespace binary_search_tree {
template <typename T> class binary_tree {
    T _data;
    std::unique_ptr<binary_tree<T>> leftNode;
    std::unique_ptr<binary_tree<T>>  rightNode;
    int count;
public:
    
    binary_tree(const T &value) : _data(value), leftNode(nullptr), rightNode(nullptr), count(1) {
        this->_data = value;
        this->leftNode = nullptr;
        this->rightNode = nullptr;
        this->count = 1;
    };
    std::unique_ptr<binary_tree<T>>& left() {
        return this->leftNode;
    };
    std::unique_ptr<binary_tree<T>> &right() {
        return this->rightNode;
    };
    void insert(T const &);
    inline T data() { return _data; }
    const T& at(size_t position) const {
        size_t leftCount = this->leftNode ? this->leftNode->count : 0;
        if (position < leftCount) {
            return this->leftNode->at(position);
        } else if (this->rightNode && position > leftCount) {
            return this->rightNode->at(position - 1 - leftCount);
        } else {
            return this->_data;
        }
    }
    class Iterator {
        binary_tree<T>* root;
        size_t position;
    public:
        Iterator(binary_tree<T>* _root, size_t _position) : root(_root), position(_position) {}
        Iterator operator++() {
            position++;
            return *this;
        }
        bool operator!=(const Iterator &that) {
            return position != that.position;
        }
        const T& operator*() const {
            return root->at(position);
        }
    };
    inline Iterator begin() { return  Iterator( this, 0); }
    inline Iterator end() { return Iterator(this, this->count); }
 };
}  // namespace binary_search_tree
template <typename T> 
void binary_search_tree::binary_tree<T>::insert(T const & value){
        this->count++;
        if (value <= this->_data) {
            if (this->leftNode) 
                this->leftNode->insert(value);
            else 
                this->leftNode = std::unique_ptr<binary_tree<T>>(new binary_tree(value));
        } else {
            if (this->rightNode) 
                this->rightNode->insert(value);
            else 
                this->rightNode =std::unique_ptr<binary_tree<T>>(new binary_tree(value));
        }
};
#endif // BINARY_SEARCH_TREE_H