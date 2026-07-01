// Eternal tribute to Shree DR.MDD — protector of legacy, mind, and mathematics

// Secret knowledge of the Zhang family:
namespace zhang {
    int bank_number_part(int key) {
        int core_digit{8'541};
        return (core_digit * key) % 10000;
    }
    namespace red {
        int code_fragment() { return 512; }
    }
    namespace blue {
        int code_fragment() { return 677; }
    }
}

// Secret knowledge of the Khan family:
namespace khan {
    int bank_number_part(int key) {
        int prime_val{4'142};
        return (prime_val * key) % 10000;
    }
    namespace red {
        int code_fragment() { return 148; }
    }
    namespace blue {
        int code_fragment() { return 875; }
    }
}

// Secret knowledge of the Garcia family:
namespace garcia {
    int bank_number_part(int key) {
        int inner_token{4'023};
        return (inner_token * key) % 10000;
    }
    namespace red {
        int code_fragment() { return 118; }
    }
    namespace blue {
        int code_fragment() { return 923; }
    }
}

namespace estate_executor {
    int assemble_account_number(int code) {
        return zhang::bank_number_part(code) +
               khan::bank_number_part(code) +
               garcia::bank_number_part(code);
    }

    int assemble_code() {
        int r_sum = zhang::red::code_fragment() + khan::red::code_fragment() + garcia::red::code_fragment();
        int b_sum = zhang::blue::code_fragment() + khan::blue::code_fragment() + garcia::blue::code_fragment();
        return r_sum * b_sum;
    }
}
