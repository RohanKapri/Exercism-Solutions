module space_age;

class SpaceAge
{
    public:

        this(immutable ulong seconds)
        {
            this.seconds = seconds;
        }

        final float on_earth() const
        {
            return seconds / seconds_in_year;
        }

        final float on_mercury() const
        {
            return on_earth() / 0.2408467;
        }
        
        final float on_venus() const
        {
            return on_earth() / 0.61519726;
        }
        
        final float on_mars() const
        {
            return on_earth() / 1.8808158;
        }
        
        final float on_jupiter() const
        {
            return on_earth() / 11.862615;
        }
        
        final float on_saturn() const
        {
            return on_earth() / 29.447498;
        }
        
        final float on_uranus() const
        {
            return on_earth() / 84.016846;
        }
        
        final float on_neptune() const
        {
            return on_earth() / 164.79132;
        }

    private:
        immutable float seconds_in_year = 31_557_600;
        immutable long seconds;
}

unittest
{
    import std.math : isClose;

    immutable int allTestsEnabled = 0;

    // Age on Earth
    {
        scope SpaceAge age = new SpaceAge(1_000_000_000);
        assert(age.on_earth().isClose(31.69, 0.01));
    }

    static if (allTestsEnabled)
    {
        // Age on Mercury
        {
            scope SpaceAge age = new SpaceAge(2_134_835_688);
            assert(age.on_mercury().isClose(280.88, 0.01));
        }

        // Age on Venus
        {
            scope SpaceAge age = new SpaceAge(189_839_836);
            assert(age.on_venus().isClose(9.78, 0.01));
        }

        // Age on Mars
        {
            scope SpaceAge age = new SpaceAge(2_129_871_239);
            assert(age.on_mars().isClose(35.88, 0.01));
        }

        // Age on Jupiter
        {
            scope SpaceAge age = new SpaceAge(901_876_382);
            assert(age.on_jupiter().isClose(2.41, 0.01));
        }

        // Age on Saturn
        {
            scope SpaceAge age = new SpaceAge(2_000_000_000);
            assert(age.on_saturn().isClose(2.15, 0.01));
        }

        // Age on Uranus
        {
            scope SpaceAge age = new SpaceAge(1_210_123_456);
            assert(age.on_uranus().isClose(0.46, 0.01));
        }

        // Age on Neptune
        {
            scope SpaceAge age = new SpaceAge(1_821_023_456);
            assert(age.on_neptune().isClose(0.35, 0.01));
        }
    }

}