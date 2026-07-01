#[derive(Drop)]
pub struct Mercury {}
#[derive(Drop)]
pub struct Venus {}
#[derive(Drop)]
pub struct Earth {}
#[derive(Drop)]
pub struct Mars {}
#[derive(Drop)]
pub struct Jupiter {}
#[derive(Drop)]
pub struct Saturn {}
#[derive(Drop)]
pub struct Uranus {}
#[derive(Drop)]
pub struct Neptune {}

pub trait Planet<T> {
    const PERIOD: u256;
    fn age(self: @T, seconds: u256) -> u256 {
        // Calculate age with 2 decimal places as integer
        // Formula: (seconds * 100 * 1,000,000) / PERIOD
        (seconds * 100_000_000) / Self::PERIOD
    }
}

impl MercuryPlanet of Planet<Mercury> {
    // 0.2408467 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 7_600_352_352_000;
}

impl VenusPlanet of Planet<Venus> {
    // 0.61519726 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 19_414_149_235_776;
}

impl EarthPlanet of Planet<Earth> {
    // 1.0 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 31_557_600_000_000;
}

impl MarsPlanet of Planet<Mars> {
    // 1.8808158 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 59_354_032_690_080;
}

impl JupiterPlanet of Planet<Jupiter> {
    // 11.862615 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 374_335_776_840_000;
}

impl SaturnPlanet of Planet<Saturn> {
    // 29.447498 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 929_292_362_404_800;
}

impl UranusPlanet of Planet<Uranus> {
    // 84.016846 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 2_651_370_019_279_360;
}

impl NeptunePlanet of Planet<Neptune> {
    // 164.79132 * 31,557,600 * 1,000,000
    const PERIOD: u256 = 5_200_418_560_032_000;
}