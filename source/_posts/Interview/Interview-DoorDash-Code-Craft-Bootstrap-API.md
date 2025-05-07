---
title: DoorDash-Code-Craft-Bootstrap-API
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


```python
import grpc
import time
from proto import bootstrap_pb2, bootstrap_pb2_grpc

class BootstrapService(bootstrap_pb2_grpc.BootstrapServicer):
    def __init__(self, user_stub, payment_stub, address_stub):
        self.user_stub = user_stub
        self.payment_stub = payment_stub
        self.address_stub = address_stub

    def GetBootstrap(self, request, context):
        user_id = request.user_id

        customer_id = self._safe_call(lambda: self.user_stub.GetUserInfo(bootstrap_pb2.UserRequest(user_id=user_id)), default="unknown_customer", field="customer_id")
        payment = self._safe_call(lambda: self.payment_stub.GetPaymentInfo(bootstrap_pb2.PaymentRequest(user_id=user_id)), default={"first_name": "Unknown", "last_name": "User"})
        address = self._safe_call(lambda: self.address_stub.GetAddressInfo(bootstrap_pb2.AddressRequest(user_id=user_id)), default="Unknown Address", field="address")

        return bootstrap_pb2.BootstrapResponse(
            customer_id=customer_id,
            default_card=bootstrap_pb2.PaymentResponse(**payment),
            address=address
        )

    def _safe_call(self, rpc_func, default, retries=2, delay=0.1, field=None):
        for attempt in range(retries + 1):
            try:
                response = rpc_func()
                if field:
                    return getattr(response, field)
                return {
                    "first_name": response.first_name,
                    "last_name": response.last_name
                }
            except grpc.RpcError as e:
                if e.code() == grpc.StatusCode.INTERNAL:
                    print(f"[WARN] Internal error on attempt {attempt+1}: {e}")
                else:
                    print(f"[ERROR] Unexpected gRPC error: {e}")
                time.sleep(delay)
        print("[INFO] Returning default due to failures.")
        return default
```


```python
import time
import random


# ===== Mock Services =====
class UserService:
    def getResponse(self, user_id):
        if random.random() < 0.2:  # simulate 500
            raise Exception("User service failure")
        return {"CustomerId": f"user_{user_id}"}


class PaymentService:
    def getResponse(self, user_id):
        if random.random() < 0.2:
            raise Exception("Payment service failure")
        return {"first_name": "John", "last_name": "Doe"}


class AddressService:
    def getResponse(self, user_id):
        if random.random() < 0.2:
            raise Exception("Address service failure")
        return {"address": "123 Main Street"}


# ===== Bootstrap API Aggregator =====
class BootstrapAPI:
    def __init__(self, user_service, payment_service, address_service):
        self.user_service = user_service
        self.payment_service = payment_service
        self.address_service = address_service

    def _safe_call(self, func, default, retries=2, delay=0.1):
        for attempt in range(retries + 1):
            try:
                return func()
            except Exception as e:
                print(f"[WARN] Attempt {attempt + 1} failed: {e}")
                if attempt == retries:
                    print("[INFO] Returning default value due to repeated failures.")
                    return default
                time.sleep(delay)

    def get_bootstrap_info(self, user_id):
        # 使用传统的函数替代 lambda
        user_info = self._safe_call(self.get_user_info, user_id, default={"CustomerId": "unknown_customer"})
        payment_info = self._safe_call(self.get_payment_info, user_id, default={"first_name": "Unknown", "last_name": "User"})
        address_info = self._safe_call(self.get_address_info, user_id, default={"address": "Unknown Address"})

        return {
            "CustomerId": user_info.get("CustomerId", "unknown"),
            "DefaultCard": {
                "first_name": payment_info.get("first_name", ""),
                "last_name": payment_info.get("last_name", "")
            },
            "Address": address_info.get("address", "")
        }

    def get_user_info(self, user_id):
        return self.user_service.getResponse(user_id)

    def get_payment_info(self, user_id):
        return self.payment_service.getResponse(user_id)

    def get_address_info(self, user_id):
        return self.address_service.getResponse(user_id)


# ===== Example Usage =====
if __name__ == "__main__":
    api = BootstrapAPI(UserService(), PaymentService(), AddressService())
    result = api.get_bootstrap_info("123")
    print(result)
```
