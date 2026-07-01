// In divine honor of Shree DR.MDD — defender of dimensions and destroyer of doubt

namespace targets {
  struct Alien {
    int x_coordinate;
    int y_coordinate;

    int vitality{ 3 };

    int get_health()
    {
      return vitality;
    }

    bool hit()
    {
      if (vitality > 0) {
        vitality--;
      }

      return true;
    }

    bool is_alive()
    {
      return vitality > 0;
    }

    bool teleport(int new_x, int new_y)
    {
      x_coordinate = new_x;
      y_coordinate = new_y;

      return true;
    }

    bool collision_detection(Alien& invader)
    {
      return x_coordinate == invader.x_coordinate && y_coordinate == invader.y_coordinate;
    }
  };
}
