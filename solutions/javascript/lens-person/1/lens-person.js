//
// This is only a SKELETON file for the 'Lens Person' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/* eslint-disable no-unused-vars */
import { Person } from './person';
import { Name } from './name';
import { Born } from './born';
import { Address } from './address';
import { Lens } from './lens';

// Implement the nameLens with the getter and setter
export const nameLens = new Lens(
  (person) => {
    return person.name
  },
  (person, name) => {
    return new Person(name, person.born, person.address)
  }
)

// Implement the bornAtLens with the getter and setter
export const bornAtLens = new Lens(
  (person) => {
    return person.born.bornAt
  },
  (person, address) => {
    let born = new Born(address, person.born.Born)
    return new Person(person.Name, born, person.Address)
  },
);

// Implement the streetLens with the getter and setter
export const streetLens = new Lens(
  (person) => {
    return person.address.street
  },
  (person, street) => {
    let address = new Address(person.address.number, 
      street,
      person.address.place,
      person.address.country
    )
    return new Person(person.Name, person.born, address)
  },
);