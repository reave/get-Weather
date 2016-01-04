
function get-weather {
    param(
        [string]$City = "Mount",
        [string]$country = "States",
        [switch]$fahrenheit
    )

    $api = "Key"

    [xml]$wr = Invoke-WebRequest "api.openweathermap.org/data/2.5/weather?q=$City,$country&APPID=$api&mode=xml"
    $data = $wr.current
    $OutputObject=@{}

    $OutputObject.City=$data.city.name 
    $OutputObject.Country=$data.city.country
    $OutputObject.Weather=$data.weather.value
    if($fahrenheit){
        $OutputObject.TempNOW="$([math]::Round(($data.temperature.value - 273.15)*1.8+32,2))°f"
        $OutputObject.TempMAX="$([math]::Round(($data.temperature.max - 273.15)*1.8+32,2))°f"
        $OutputObject.TempMIN="$([math]::Round(($data.temperature.min - 273.15)*1.8+32,2))°f"
    }
    else{
        $OutputObject.TempNOW="$([math]::Round(($data.temperature.value - 273.15),2))°C"
        $OutputObject.TempMAX="$([math]::Round(($data.temperature.max - 273.15),2))°C"
        $OutputObject.TempMIN="$([math]::Round(($data.temperature.min - 273.15),2))°C"
    }
    $OutputObject.Humidity="$($data.humidity.value) $($data.humidity.unit)"
    $OutputObject.Clouds=$data.clouds.name
    $OutputObject.Rain=$data.precipitation.mode
    $OutputObject.Wind=$data.wind.speed.name
    $OutputObject.Pressure=$data.pressure.value
    return $OutputObject
}
