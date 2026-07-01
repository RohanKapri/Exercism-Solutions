#include "rotational_cipher.h"
namespace rotational_cipher {
    inline char encode(char ch, int key, char base) {
        return (ch - base + key) % 26 + base;
    }
    std::string rotate(const std::string& text, int key) {
        std::string cipher;
        for (char ch: text) {
            if (std::isupper(ch))
                cipher.push_back(encode(ch, key, 'A'));
            else if (std::islower(ch))
                cipher.push_back(encode(ch, key, 'a'));
            else
                cipher.push_back(ch);
        }
        return cipher;
    }
}  // namespace rotational_cipher
