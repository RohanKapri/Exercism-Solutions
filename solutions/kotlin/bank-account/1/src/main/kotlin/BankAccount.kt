class BankAccount {
    private val lock = Any()
    private var _balance: Long = 0
    private var closed: Boolean = false

    val balance: Long
        get() = synchronized(lock) {
            ensureOpen()
            _balance
        }

    fun adjustBalance(amount: Long) {
        synchronized(lock) {
            ensureOpen()
            _balance += amount
        }
    }

    fun close() {
        synchronized(lock) {
            closed = true
        }
    }

    fun ensureOpen() {
        if (closed) throw IllegalStateException()
    }
}