mkdir -p ../HelpMeCount/Services/NetworkService/GeneratedLayer

if openapi-generator generate -i "specs.yaml" -g swift6 --additional-properties=responseAs=AsyncAwait -o "api-mobile"; then
    rm -rf ../HelpMeCount/Services/NetworkService/GeneratedLayer/GeneratedSources
    mkdir -p ../HelpMeCount/Services/NetworkService/GeneratedLayer/GeneratedSources

    cp -R ./api-mobile/Sources/OpenAPIClient/APIs ../HelpMeCount/Services/NetworkService/GeneratedLayer/GeneratedSources
    cp -R ./api-mobile/Sources/OpenAPIClient/Infrastructure ../HelpMeCount/Services/NetworkService/GeneratedLayer/GeneratedSources
    cp -R ./api-mobile/Sources/OpenAPIClient/Models ../HelpMeCount/Services/NetworkService/GeneratedLayer/GeneratedSources

    echo "Success"
else
    echo "Fail"
fi


