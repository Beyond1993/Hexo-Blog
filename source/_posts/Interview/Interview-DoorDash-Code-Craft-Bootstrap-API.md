---
DoorDash-Code-Craft-Bootstrap-API
date: 2025-04-15 11:50:55
categories: Interview
tags:
---


https://www.1point3acres.com/bbs/thread-1119279-1-1.html
https://www.1point3acres.com/bbs/thread-1066887-1-1.html
https://www.1point3acres.com/bbs/thread-1110797-1-1.html

```python
import time
import random

# 模拟服务类（已经实现的）
class UserService:
    def get_response(self, user_id: str):
        # 模拟有概率失败的服务
        if random.random() < 0.2:
            raise Exception("UserService failure")
        return {"customer_id": f"cust_{user_id}"}

class PaymentService:
    def get_response(self, user_id: str):
        # 模拟有概率失败的服务
        if random.random() < 0.3:
            raise Exception("PaymentService failure")
        return {"first_name": "John", "last_name": "Doe"}

class AddressService:
    def get_response(self, user_id: str):
        # 模拟有概率失败的服务
        if random.random() < 0.2:
            raise Exception("AddressService failure")
        return {"address": "123 Main St, Springfield"}

# 聚合器类：BootstrapService
class BootstrapService:
    def __init__(self, payment_service, user_service, address_service):
        self.payment_service = payment_service
        self.user_service = user_service
        self.address_service = address_service

    def get_bootstrap_info(self, user_id: str) -> dict:
        user_response = self._try_get(self.user_service.get_response, user_id, default={"customer_id": "unknown_customer"})
        payment_response = self._try_get(self.payment_service.get_response, user_id, default={"first_name": "Unknown", "last_name": "User"})
        address_response = self._try_get(self.address_service.get_response, user_id, default={"address": "Unknown Address"})

        return {
            "CustomerId": user_response.get("customer_id"),
            "DefaultCard": {
                "first_name": payment_response.get("first_name"),
                "last_name": payment_response.get("last_name")
            },
            "Address": address_response.get("address")
        }

    def _try_get(self, service_method, user_id, default, retries=2, delay_sec=0.2):
        for attempt in range(retries + 1):
            try:
                return service_method(user_id)
            except Exception as e:
                print(f"[WARN] Attempt {attempt + 1} failed: {e}")
                if attempt == retries:
                    print("[INFO] Returning fallback default value.")
                    return default
                time.sleep(delay_sec)

# ==========================
# Example usage of the API
# ==========================
user_service = UserService()
payment_service = PaymentService()
address_service = AddressService()

bootstrap_service = BootstrapService(payment_service, user_service, address_service)

user_id = "12345"
result = bootstrap_service.get_bootstrap_info(user_id)

print(result)

```
