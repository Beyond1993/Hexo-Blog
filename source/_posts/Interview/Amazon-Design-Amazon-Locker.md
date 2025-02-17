---
title: Amazon-Design-Amazon-Locker
date: 2025-02-17 12:10:46
categories: Interview
tags:
---

Designing an Amazon Locker System in an Object-Oriented Design (OOD) interview requires careful planning around classes, responsibilities, interactions, and constraints. Below is a structured approach to solving this design problem:

1. Clarify Requirements
Before jumping into design, clarify functional and non-functional requirements.

Functional Requirements
A customer can drop off and pick up a package using a unique code.
A package must be assigned a locker of appropriate size.
If no lockers are available, the package cannot be stored.
Customers should receive a notification with a pickup code.
Lockers can be occupied, vacant, or broken.
A package should be retrieved within a time limit before returning to the sender.
Non-Functional Requirements
Scalability: Must handle multiple locations and large customer demand.
Security: Only the correct recipient can retrieve the package.
Fault Tolerance: The system should handle broken lockers.
2. Identify Key Entities
Primary Objects
LockerSystem - Manages lockers, assigns them to packages, and handles retrieval.
Locker - Represents an individual locker.
Package - Represents a package stored in a locker.
Customer - Represents a user picking up a package.
NotificationService - Sends notifications with pickup codes.
CodeManager - Generates and validates secure pickup codes.

```python
from enum import Enum
import uuid
from datetime import datetime, timedelta

class LockerSize(Enum):
    SMALL = "SMALL"
    MEDIUM = "MEDIUM"
    LARGE = "LARGE"

class LockerStatus(Enum):
    AVAILABLE = "AVAILABLE"
    OCCUPIED = "OCCUPIED"
    BROKEN = "BROKEN"

class Locker:
    def __init__(self, locker_id: int, size: LockerSize):
        self.locker_id = locker_id
        self.size = size
        self.status = LockerStatus.AVAILABLE
        self.package = None

    def assign_package(self, package):
        if self.status == LockerStatus.AVAILABLE:
            self.package = package
            self.status = LockerStatus.OCCUPIED
            return True
        return False

    def release_package(self):
        if self.status == LockerStatus.OCCUPIED:
            self.package = None
            self.status = LockerStatus.AVAILABLE

class Package:
    def __init__(self, package_id: str, size: LockerSize):
        self.package_id = package_id
        self.size = size
        self.pickup_code = str(uuid.uuid4())[:8]  # Generate a secure pickup code
        self.expiry_time = datetime.now() + timedelta(days=3)  # 3-day expiry

class Customer:
    def __init__(self, name: str, phone: str):
        self.name = name
        self.phone = phone

class LockerSystem:
    def __init__(self):
        self.lockers = []

    def add_locker(self, locker: Locker):
        self.lockers.append(locker)

    def find_available_locker(self, size: LockerSize):
        for locker in self.lockers:
            if locker.size == size and locker.status == LockerStatus.AVAILABLE:
                return locker
        return None

    def store_package(self, package: Package):
        locker = self.find_available_locker(package.size)
        if not locker:
            print("No available lockers for size:", package.size)
            return None
        locker.assign_package(package)
        print(f"Package {package.package_id} stored in Locker {locker.locker_id} with code {package.pickup_code}")
        return package.pickup_code

    def retrieve_package(self, pickup_code: str):
        for locker in self.lockers:
            if locker.package and locker.package.pickup_code == pickup_code:
                print(f"Package {locker.package.package_id} retrieved from Locker {locker.locker_id}")
                locker.release_package()
                return True
        print("Invalid or expired pickup code.")
        return False

class NotificationService:
    @staticmethod
    def send_notification(customer: Customer, pickup_code: str):
        print(f"Notification sent to {customer.phone}: Your pickup code is {pickup_code}")

# Example Usage
if __name__ == "__main__":
    locker_system = LockerSystem()
    locker_system.add_locker(Locker(1, LockerSize.SMALL))
    locker_system.add_locker(Locker(2, LockerSize.MEDIUM))
    
    customer = Customer("Alice", "123-456-7890")
    package = Package("PKG123", LockerSize.SMALL)

    code = locker_system.store_package(package)
    if code:
        NotificationService.send_notification(customer, code)

    locker_system.retrieve_package(code)  # Simulate package retrieval
```

```python
import threading
from enum import Enum
import uuid
from datetime import datetime, timedelta

class LockerSize(Enum):
    SMALL = "SMALL"
    MEDIUM = "MEDIUM"
    LARGE = "LARGE"

class LockerStatus(Enum):
    AVAILABLE = "AVAILABLE"
    OCCUPIED = "OCCUPIED"
    BROKEN = "BROKEN"

class Locker:
    def __init__(self, locker_id: int, size: LockerSize):
        self.locker_id = locker_id
        self.size = size
        self.status = LockerStatus.AVAILABLE
        self.package = None
        self.lock = threading.Lock()  # Lock to ensure thread safety

    def assign_package(self, package):
        with self.lock:  # Ensure atomicity of locker assignment
            if self.status == LockerStatus.AVAILABLE:
                self.package = package
                self.status = LockerStatus.OCCUPIED
                return True
        return False

    def release_package(self):
        with self.lock:  # Ensure atomicity of package retrieval
            if self.status == LockerStatus.OCCUPIED:
                self.package = None
                self.status = LockerStatus.AVAILABLE

class Package:
    def __init__(self, package_id: str, size: LockerSize):
        self.package_id = package_id
        self.size = size
        self.pickup_code = str(uuid.uuid4())[:8]  # Generate a secure pickup code
        self.expiry_time = datetime.now() + timedelta(days=3)  # 3-day expiry

class LockerSystem:
    def __init__(self):
        self.lockers = []
        self.system_lock = threading.Lock()  # Global lock for managing lockers

    def add_locker(self, locker: Locker):
        with self.system_lock:
            self.lockers.append(locker)

    def find_available_locker(self, size: LockerSize):
        with self.system_lock:  # Prevent concurrent modifications
            for locker in self.lockers:
                if locker.size == size and locker.status == LockerStatus.AVAILABLE:
                    return locker
        return None

    def store_package(self, package: Package):
        locker = self.find_available_locker(package.size)
        if not locker:
            print("No available lockers for size:", package.size)
            return None
        if locker.assign_package(package):  # Ensures thread-safe assignment
            print(f"Package {package.package_id} stored in Locker {locker.locker_id} with code {package.pickup_code}")
            return package.pickup_code
        return None

    def retrieve_package(self, pickup_code: str):
        with self.system_lock:  # Locking during package retrieval check
            for locker in self.lockers:
                if locker.package and locker.package.pickup_code == pickup_code:
                    locker.release_package()  # Ensures safe update
                    print(f"Package {locker.package.package_id} retrieved from Locker {locker.locker_id}")
                    return True
        print("Invalid or expired pickup code.")
        return False
```

