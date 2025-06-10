Class READYforACTION.disp Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/dataset/:name" Method="get" Call="GenerateDataset" />
  <Route Url="/fetchdata/:name/:id" Method="get" Call="FetchData" />
</Routes>
}

ClassMethod GenerateDataset(pName) As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(READYforACTION.impl).GenerateDataset(pName)
        Write response
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": (ex.AsStatus())}
    }
    Quit $$$OK
}

ClassMethod FetchData(pName, pID) As %Status
{
    Try {
        If '##class(%REST.Impl).%CheckAccepts("application/json") Do ##class(%REST.Impl).%ReportRESTError(..#HTTP406NOTACCEPTABLE,$$$ERROR($$$RESTBadAccepts)) Quit
        Set response=##class(READYforACTION.impl).FetchData(pName,pID)
        Write response
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("400")
        return {"errormessage": (ex.AsStatus())}
    }
    Quit $$$OK
}

}
