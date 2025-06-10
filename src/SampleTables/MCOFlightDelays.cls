Class SampleTables.MCOFlightDelays Extends %Persistent [ Not ProcedureBlock ]
{

ClassMethod LoadData(pFile = "") As %Status
{
    Set tSC=$$$OK

    If pFile="" {
        Set tSC=$$$ERROR($$$GeneralError,"File missing for LoadData")
        Quit tSC
    }

    Set tSQL="LOAD DATA FROM FILE '"_pFile_"' INTO SampleTables.MCOFlightDelays"
    Set tRS=##class(%SQL.Statement).%ExecDirect(,tSQL)
    If tRS.%SQLCODE'=0 { Set tSC=tRS.%SQLCODE }

    Quit tSC
}

Property Airline As %String(MAXLEN = "") [ SqlColumnNumber = 3 ];

Property CauseOfDelay As %String(MAXLEN = "") [ SqlColumnNumber = 4 ];

Property Date As %Date [ SqlColumnNumber = 2, SqlFieldName = Date_SQLSafe ];

Property DelayDuration As %Integer [ SqlColumnNumber = 5 ];

Method DateSet(pVal) As %Status
{
 Try { Set pVal=$zdh(pVal,3,,5,"99") }
 Catch ex {  }
 Set i%Date=pVal
 Quit $$$OK
}

ClassMethod FetchData(pID) As %DynamicObject
{
    &sql(SELECT JSON_OBJECT('Date':%ODBCOUT(Date_SQLSafe), 'Airline':Airline, 'CauseOfDelay':CauseOfDelay, 'DelayDuration':DelayDuration) INTO :tJSONData FROM SampleTables.MCOFlightDelays WHERE %ID=:pID)
    Return tJSONData
}

ClassMethod DelayReport(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
    Set pContext.command="popup:http://localhost:61773/csp/user/DelayReport.html?id="_pContext.valueList
    Quit $$$OK
}

Storage Default
{
<Data name="MCOFlightDelaysDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Airline</Value>
</Value>
<Value name="3">
<Value>CauseOfDelay</Value>
</Value>
<Value name="4">
<Value>Date</Value>
</Value>
<Value name="5">
<Value>DelayDuration</Value>
</Value>
</Data>
<DataLocation>^SampleTables.MCOFlightDelaysD</DataLocation>
<DefaultData>MCOFlightDelaysDefaultData</DefaultData>
<IdLocation>^SampleTables.MCOFlightDelaysD</IdLocation>
<IndexLocation>^SampleTables.MCOFlightDelaysI</IndexLocation>
<StreamLocation>^SampleTables.MCOFlightDelaysS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
