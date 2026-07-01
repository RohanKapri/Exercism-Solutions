#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H
#include <vector>
#include <string>
#include <stdexcept>
namespace circular_buffer
{
    template <typename T>
    class circular_buffer
    {
    private:
        std::vector<T> buffer{};
        std::size_t idx_read{0};
        std::size_t idx_write{0};
        bool is_empty{true};
        bool is_full{false};
    public:
        circular_buffer<T>(int length)
        {
            buffer.reserve(length);
        }
        T read(void);
        void write(T);
        void overwrite(T);
        void clear(void);
    };
    template <typename T>
    T circular_buffer<T>::read()
    {
        if (is_empty)
            throw std::domain_error("Buffer empty!");
        T read_item = buffer[idx_read];
        is_full = false;
        idx_read = (idx_read + 1) % buffer.capacity();
        if (idx_read == idx_write)
            is_empty = true;
        return read_item;
    }
    template <typename T>
    void circular_buffer<T>::write(T new_item)
    {
        if (is_full)
            throw std::domain_error("Buffer is full!");
        is_empty = false;
        buffer[idx_write] = new_item;
        idx_write = (idx_write + 1) % buffer.capacity();
        if (idx_write == idx_read)
            is_full = true;
    }
    template <typename T>
    void circular_buffer<T>::overwrite(T new_item)
    {
        if (is_full)
        {
            idx_read = (idx_read + 1) % buffer.capacity();
            is_full = false;
        }
        write(new_item);
    }
    template <typename T>
    void circular_buffer<T>::clear(void)
    {
        idx_read = 0;
        idx_write = 0;
        is_empty = true;
        is_full = false;
    }
} // namespace circular_buffer
#endif // CIRCULAR_BUFFER_H