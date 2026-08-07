import java.time.Duration;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

public class RateLimiter<K> {
    private final int limit;
    private final Duration windowSize;
    private final TimeSource timeSource;
    private final Map<K, ClientState> states;

    private class ClientState {
        private Instant windowStart;
        private int count;

        private ClientState(Instant windowStart, int count) {
            this.windowStart = windowStart;
            this.count = count;
        }
    }

    public RateLimiter(int limit, Duration windowSize, TimeSource timeSource) {
        this.limit = limit;
        this.windowSize = windowSize;
        this.timeSource = timeSource;
        this.states = new HashMap<>();
    }

    public boolean allow(K clientId) {
        Instant now = timeSource.now();
        ClientState state = states.get(clientId);

        if (state == null) {
            states.put(clientId, new ClientState(now, 1));
            return true;
        }

        Instant windowEnd = state.windowStart.plus(windowSize);

        if (!now.isBefore(windowEnd)) {
            state.windowStart = now;
            state.count = 1;
            return true;
        }

        if (state.count < limit) {
            state.count++;
            return true;
        }

        return false;
    }
}