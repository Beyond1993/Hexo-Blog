---
title: Parking Lot
date: 2020-03-11 10:23:34
categories: Object-Oriented-Design
tags:
---

1. are we going to design multiple level parking lot ?
2. what kinds of vehicle?
3. handicap parking spot?

- Parking lot: mutiple level Parking lot, 
- Vehicle: one size
- handicap parking spot 


Core Object:

spot object ?
vehicle object ? 
receipt object ?
scheduler object ? <==> ParkingLot

helper class:
Level

cases:

1. Get available count
2. park vehicle
2.1  Get available count
2.2  get appropriate spot
2.3  record start time
2.3  park



4 leave 
4.1 record end timer
4.2 (end - start) * rate ==> charge
4.3 clear spot

Management Use case:
- Reservation : X
- Serve: Park vehicle
- Check out: Clear spot + Calculate price

parking lot core feature: Reservation
hotel core feature: serve

S.O.L.I.D







