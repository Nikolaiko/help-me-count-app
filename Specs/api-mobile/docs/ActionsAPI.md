# ActionsAPI

All URIs are relative to *http://e97b67a8bc6.vps.myjino.ru:49235*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addAction**](ActionsAPI.md#addaction) | **POST** /actions/add/ | Добавить действие
[**editAction**](ActionsAPI.md#editaction) | **POST** /actions/edit/ | Изменить действие
[**getAction**](ActionsAPI.md#getaction) | **GET** /actions/{actionid}/ | Получить действие по id
[**getAllActions**](ActionsAPI.md#getallactions) | **GET** /actions/ | Получить список всех действий


# **addAction**
```swift
    open class func addAction(newRepeatableAction: NewRepeatableAction? = nil, completion: @escaping (_ data: RepeatableAction?, _ error: Error?) -> Void)
```

Добавить действие

Добавить действие

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let newRepeatableAction = NewRepeatableAction(title: "title_example", maxRepeats: 123, currentRepeats: 123) // NewRepeatableAction |  (optional)

// Добавить действие
ActionsAPI.addAction(newRepeatableAction: newRepeatableAction) { (response, error) in
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
 **newRepeatableAction** | [**NewRepeatableAction**](NewRepeatableAction.md) |  | [optional] 

### Return type

[**RepeatableAction**](RepeatableAction.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **editAction**
```swift
    open class func editAction(actionid: UUID, repeatableAction: RepeatableAction? = nil, completion: @escaping (_ data: RepeatableAction?, _ error: Error?) -> Void)
```

Изменить действие

Изменить действие

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let actionid = 987 // UUID | Id искомого действия
let repeatableAction = RepeatableAction(id: 123, title: "title_example", maxRepeats: 123, currentRepeats: 123) // RepeatableAction |  (optional)

// Изменить действие
ActionsAPI.editAction(actionid: actionid, repeatableAction: repeatableAction) { (response, error) in
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
 **actionid** | **UUID** | Id искомого действия | 
 **repeatableAction** | [**RepeatableAction**](RepeatableAction.md) |  | [optional] 

### Return type

[**RepeatableAction**](RepeatableAction.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAction**
```swift
    open class func getAction(actionid: UUID, completion: @escaping (_ data: RepeatableAction?, _ error: Error?) -> Void)
```

Получить действие по id

Получить действие по id

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient

let actionid = 987 // UUID | Id искомого действия

// Получить действие по id
ActionsAPI.getAction(actionid: actionid) { (response, error) in
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
 **actionid** | **UUID** | Id искомого действия | 

### Return type

[**RepeatableAction**](RepeatableAction.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllActions**
```swift
    open class func getAllActions(completion: @escaping (_ data: [RepeatableAction]?, _ error: Error?) -> Void)
```

Получить список всех действий

Получить список всех действий

### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import OpenAPIClient


// Получить список всех действий
ActionsAPI.getAllActions() { (response, error) in
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

[**[RepeatableAction]**](RepeatableAction.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

