function get-weather {
    param(
        [string]$City = "Default City",
        [string]$country = "Default Country",
        [switch]$fahrenheit
    )

    $api = "Key"

    [xml]$wr = Invoke-WebRequest "api.openweathermap.org/data/2.5/weather?q=$City,$country&APPID=$api&mode=xml"
    $data = $wr.current
    $OutputObject= New-Object -TypeName psobject

    $OutputObject | Add-Member -MemberType NoteProperty -Name 'City' -Value $data.city.name 
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Country' -Value $data.city.country
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'CurrentWeather' -Value $data.weather.value
    if($fahrenheit){
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'NowTemperature' -Value "$([math]::Round(($data.temperature.value - 273.15)*1.8+32,2))°f"
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'HighTemperature' -Value "$([math]::Round(($data.temperature.max - 273.15)*1.8+32,2))°f"
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'LowTemperature' -Value "$([math]::Round(($data.temperature.min - 273.15)*1.8+32,2))°f"
    }
    else{
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'NowTemperature' -Value "$([math]::Round(($data.temperature.value - 273.15),2))°C"
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'HighTemperature' -Value "$([math]::Round(($data.temperature.max - 273.15),2))°C"
        $OutputObject | Add-Member -MemberType NoteProperty -Name 'LowTemperature' -Value "$([math]::Round(($data.temperature.min - 273.15),2))°C"
    }
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Humidity' -Value "$($data.humidity.value) $($data.humidity.unit)"
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Clouds' -Value $data.clouds.name
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Rain' -Value $data.precipitation.mode
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Wind' -Value $data.wind.speed.name
    $OutputObject | Add-Member -MemberType NoteProperty -Name 'Pressure' -Value $data.pressure.value
    return $OutputObject
}
