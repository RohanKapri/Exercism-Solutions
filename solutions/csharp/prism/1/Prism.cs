public static class Prism
{
    public readonly record struct LaserInfo(double X, double Y, double Angle);

    public readonly record struct PrismInfo(int Id, double X, double Y, double Angle);

    public static int[] FindSequence(LaserInfo laser, PrismInfo[] prisms)
    {
        var result = new List<int>();

        double x = laser.X;
        double y = laser.Y;
        double angle = laser.Angle;

        int maxSteps = prisms.Length * 5;

        for (int step = 0; step < maxSteps; step++)
        {
            PrismInfo? nextPrism = null;
            double minDist = double.MaxValue;

            double rad = angle * Math.PI / 180.0;
            double dx = Math.Cos(rad);
            double dy = Math.Sin(rad);

            foreach (var p in prisms)
            {
                double vx = p.X - x;
                double vy = p.Y - y;
            
                double dist = Math.Sqrt(vx * vx + vy * vy);
                if (dist == 0) continue;
            
                double dirX = vx / dist;
                double dirY = vy / dist;

                double dot = dirX * dx + dirY * dy;

                if (dot <= 0.999) continue; 
            
                if (dist < minDist)
                {
                    minDist = dist;
                    nextPrism = p;
                }
            }

            if (nextPrism == null)
            {
                break;
            }

            var hit = nextPrism.Value;
            result.Add(hit.Id);

            x = hit.X;
            y = hit.Y;

            angle += hit.Angle;

            if (angle >= 360) angle %= 360;
            if (angle < 0) angle = 360 + (angle % 360);
        }
        return result.ToArray();
    }
}