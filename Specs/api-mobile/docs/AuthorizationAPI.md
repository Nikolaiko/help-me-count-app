# AuthorizationAPI

All URIs are relative to *http://e97b67a8bc6.vps.myjino.ru:49235*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](AuthorizationAPI.md#login) | **POST** /authorization/login/ | Логин для зареганых пользователей
[**refresh**](AuthorizationAPI.md#refresh) | **POST** /authorization/refresh/ | Обновление токена
[**register**](AuthorizationAPI.md#register) | **POST** /authorization/register/ | Логин для зареганых пользователей


# **login**
```swift
    open class func login(completion: @escaping (_ data: AuthResponse?, _ error: Error?) -> Void)
```

Логин для зареганых пользователей

Логин для зареганых пользователей

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Логин для зареганых пользователей
AuthorizationAPI.login() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthResponse**](AuthResponse.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refresh**
```swift
    open class func refresh(completion: @escaping (_ data: AuthResponse?, _ error: Error?) -> Void)
```

Обновление токена

Обновление токена

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Обновление токена
AuthorizationAPI.refresh() { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AuthResponse**](AuthResponse.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
```swift
    open class func register(authRequest: AuthRequest? = nil, completion: @escaping (_ data: AuthResponse?, _ error: Error?) -> Void)
```

Логин для зареганых пользователей

Логин для зареганых пользователей

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let authRequest = AuthRequest(username: "username_example", password: "password_example") // AuthRequest |  (optional)

// Логин для зареганых пользователей
AuthorizationAPI.register(authRequest: authRequest) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authRequest** | [**AuthRequest**](AuthRequest.md) |  | [optional] 

### Return type

[**AuthResponse**](AuthResponse.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

