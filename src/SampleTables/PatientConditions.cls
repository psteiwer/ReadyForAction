Class SampleTables.PatientConditions Extends %Persistent [ Not ProcedureBlock ]
{

ClassMethod LoadData(pFile = "") As %Status
{
    Set tSC=$$$OK

    If pFile="" {
        Set tSC=$$$ERROR($$$GeneralError,"File missing for LoadData")
        Quit tSC
    }

    Set tSQL="LOAD DATA FROM FILE '"_pFile_"' INTO SampleTables.PatientConditions"
    Set tRS=##class(%SQL.Statement).%ExecDirect(,tSQL)
    If tRS.%SQLCODE'=0 { Set tSC=tRS.%SQLCODE }

    Quit tSC
}

Property BirthDate As %Date [ SqlColumnNumber = 3 ];

Property City As %String(MAXLEN = "") [ SqlColumnNumber = 5 ];

Property Condition As %String(MAXLEN = "") [ SqlColumnNumber = 6 ];

Property Country As %String(MAXLEN = "") [ SqlColumnNumber = 4 ];

Property MRN As %String(MAXLEN = "") [ SqlColumnNumber = 2 ];

Method BirthDateSet(pVal) As %Status
{
 Try { Set pVal=$zdh(pVal,3,,5,"99") }
 Catch ex {  }
 Set i%BirthDate=pVal
 Quit $$$OK
}

Storage Default
{
<Data name="PatientConditionsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>BirthDate</Value>
</Value>
<Value name="3">
<Value>City</Value>
</Value>
<Value name="4">
<Value>Condition</Value>
</Value>
<Value name="5">
<Value>Country</Value>
</Value>
<Value name="6">
<Value>MRN</Value>
</Value>
</Data>
<DataLocation>^SampleTables.PatientCond99D3D</DataLocation>
<DefaultData>PatientConditionsDefaultData</DefaultData>
<IdLocation>^SampleTables.PatientCond99D3D</IdLocation>
<IndexLocation>^SampleTables.PatientCond99D3I</IndexLocation>
<StreamLocation>^SampleTables.PatientCond99D3S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
