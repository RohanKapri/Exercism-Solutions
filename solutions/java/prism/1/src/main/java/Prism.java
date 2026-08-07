import java.util.*;

public class Prism {
    private static final double MAX_DISTANCE_FROM_RAY = 0.11;
    private static final double FORWARD_EPS = 1e-9;

    public record LaserInfo(double x, double y, double angle) {
    }

    public record PrismInfo(int id, double x, double y, double angle) {
    }

    public static List<Integer> findSequence(LaserInfo laser, List<PrismInfo> prisms) {
        List<Integer> answer = new ArrayList<>();

        double currentX = laser.x();
        double currentY = laser.y();
        double currentAngle = laser.angle();

        while (true) {
            double angle = normalizeAngle(currentAngle);
            double radians = Math.toRadians(angle);

            double dx = Math.cos(radians);
            double dy = Math.sin(radians);

            PrismInfo nextPrism = null;
            double bestDistance = Double.POSITIVE_INFINITY;

            for (PrismInfo prism : prisms) {
                double vx = prism.x() - currentX;
                double vy = prism.y() - currentY;

                double cross = dx * vy - dy * vx;
                if (Math.abs(cross) > MAX_DISTANCE_FROM_RAY) {
                    continue;
                }

                double dot = dx * vx + dy * vy;
                if (dot <= FORWARD_EPS) {
                    continue;
                }

                if (dot < bestDistance) {
                    bestDistance = dot;
                    nextPrism = prism;
                }
            }

            if (nextPrism == null) {
                break;
            }

            answer.add(nextPrism.id());
            currentX = nextPrism.x();
            currentY = nextPrism.y();
            currentAngle += nextPrism.angle();
        }

        return answer;
    }

    private static double normalizeAngle(double angle) {
        double normalized = angle % 360.0;
        if (normalized < 0) {
            normalized += 360.0;
        }
        return normalized;
    }
}