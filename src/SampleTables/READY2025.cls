Class SampleTables.READY2025 Extends %Persistent [ Not ProcedureBlock ]
{

ClassMethod LoadData(pFile = "") As %Status
{
    Set tSC=$$$OK

    If pFile="" {
        Set tSC=$$$ERROR($$$GeneralError,"File missing for LoadData")
        Quit tSC
    }

    Set tSQL="LOAD DATA FROM FILE '"_pFile_"' "
            _"INTO SampleTables.READY2025 (FirstName,Company,OrgType,JobTitle,Level_sqlsafe,Role_sqlsafe,Country,Industry,SubIndustry,RegistrationDate) "
            _"VALUES (FirstName,Company,OrgType,JobTitle,""Level"",""Role"",Country,Industry,SubIndustry,RegistrationDate)"
    Set tRS=##class(%SQL.Statement).%ExecDirect(,tSQL)
    If tRS.%SQLCODE'=0 { Set tSC=tRS.%SQLCODE }

    Quit tSC
}

Property Company As %String(COLLATION = "truncate", MAXLEN = 50) [ SqlColumnNumber = 3 ];

Property Country As %String(MAXLEN = "") [ SqlColumnNumber = 8 ];

Property FirstName As %String(MAXLEN = "") [ SqlColumnNumber = 2 ];

Property Industry As %String(MAXLEN = "") [ SqlColumnNumber = 9 ];

Property JobTitle As %String(COLLATION = "truncate", MAXLEN = 50) [ SqlColumnNumber = 5 ];

Property Level As %String(MAXLEN = "") [ SqlColumnNumber = 6, SqlFieldName = Level_SQLSafe ];

Property OrgType As %String(MAXLEN = "") [ SqlColumnNumber = 4 ];

Property RegistrationDate As %Date [ SqlColumnNumber = 11 ];

Property PreviousSummits As %BigInt [ Calculated, SqlColumnNumber = 12, SqlComputeCode = { Set {*} = $random(15) }, SqlComputed ];

Property Role As %String(MAXLEN = "") [ SqlColumnNumber = 7, SqlFieldName = Role_SQLSafe ];

Property SubIndustry As %String(MAXLEN = "") [ SqlColumnNumber = 10 ];

Method RegistrationDateSet(pVal) As %Status
{
 Try { Set pVal=$zdh(pVal,1,,5,"99") }
 Catch ex {  }
 Set i%RegistrationDate=pVal
 Quit $$$OK
}

ClassMethod FetchData(pID) As %DynamicObject
{
    &sql(SELECT JSON_OBJECT('FirstName':FirstName, 'Company':Company, 'OrgType':OrgType, 'JobTitle':JobTitle, 'Level':Level_sqlsafe, 'Role':Role_sqlsafe, 'Country':Country, 'Industry':Industry, 'SubIndustry':SubIndustry, 'RegistrationDate':%ODBCOUT(RegistrationDate)) INTO :tJSONData FROM SampleTables.READY2025 WHERE %ID=:pID)
    Return tJSONData
}

ClassMethod EditAction(pAction As %String, pContext As %ZEN.proxyObject) As %Status
{
    Set pContext.command="popup:http://localhost:61773/csp/user/EditRegistration.html?id="_pContext.valueList
    Quit $$$OK
}

Storage Default
{
<Data name="READY2025DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>AccountOwner</Value>
</Value>
<Value name="3">
<Value>Company</Value>
</Value>
<Value name="4">
<Value>ContactLeadOwner</Value>
</Value>
<Value name="5">
<Value>Country</Value>
</Value>
<Value name="6">
<Value>Email</Value>
</Value>
<Value name="7">
<Value>FirstName</Value>
</Value>
<Value name="8">
<Value>ISOrgID</Value>
</Value>
<Value name="9">
<Value>Industry</Value>
</Value>
<Value name="10">
<Value>JobTitle</Value>
</Value>
<Value name="11">
<Value>LastName</Value>
</Value>
<Value name="12">
<Value>Level</Value>
</Value>
<Value name="13">
<Value>MarketSegment</Value>
</Value>
<Value name="14">
<Value>OrgID</Value>
</Value>
<Value name="15">
<Value>OrgType</Value>
</Value>
<Value name="16">
<Value>RegistrationDate</Value>
</Value>
<Value name="17">
<Value>RegistrationTime</Value>
</Value>
<Value name="18">
<Value>Role</Value>
</Value>
<Value name="19">
<Value>SubIndustry</Value>
</Value>
<Value name="20">
<Value>PegaID</Value>
</Value>
<Value name="21">
<Value>PreviousSummits</Value>
</Value>
</Data>
<DataLocation>^SampleTables.READY2025D</DataLocation>
<DefaultData>READY2025DefaultData</DefaultData>
<IdLocation>^SampleTables.READY2025D</IdLocation>
<IndexLocation>^SampleTables.READY2025I</IndexLocation>
<StreamLocation>^SampleTables.READY2025S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
