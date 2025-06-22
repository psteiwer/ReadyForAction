Class READYforACTION.impl Extends %CSP.REST
{

ClassMethod GenerateDataset(pName) As %DynamicObject
{

    Try {
        Set tSQL="SELECT MRN, BirthDate, Country, City, Condition FROM SampleTables.PatientConditions"
        Set tLines=10001
        Set tCube="PatientConditions"

        If pName="READY2025" {
            Set tSQL="SELECT FirstName, Level_SQLSafe As ""Level"", Role_SQLSafe As ""Role"", Country, RegistrationDate, PreviousSummits FROM SampleTables.READY2025"
            Set tLines=10001
            Set tCube="READY2025"
        } ElseIf pName="MCOFlightDelays" {
            Set tSQL="SELECT Date_SQLSafe As ""Date"", Airline, CauseOfDelay, DelayDuration FROM SampleTables.MCOFlightDelays"
            Set tLines=20000
            Set tCube="MCOFlightDelays"
        }

        // AnalyzeThis: Generate Cube + Dashboard
        Set tSC=##class(AnalyzeThis.Utils).SQLToJSON(tSQL,.tPropertyJSONStreamId,.tDataJSONStreamId)
        Set tSC=##class(AnalyzeThis.Generator).GenerateAll("SQL",tSQL,tLines,,tCube,tPropertyJSONStreamId,tDataJSONStreamId)

        // CustomCubeActionManager: Register new cube for use + Assign custom actions
        Do ##class(CustomCubeActions.Utils).GenerateActionClass(tCube)
        Do ##class(CustomCubeActions.Utils).UpdateActionClass(tCube,"CustomCubeActions.ActionClass."_tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToJupyter","PivotToJupyter.CustomKPIAction","%OnDashboardAction",tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToPowerBI","PivotToPowerBI.CustomKPIAction","%OnDashboardAction",tCube)
        Do:tCube="READY2025" ##class(CustomCubeActions.Actions).AddAction("Edit","SampleTables."_tCube,"EditAction",tCube)
        Do:tCube="MCOFlightDelays" ##class(CustomCubeActions.Actions).AddAction("DelayReport","SampleTables."_tCube,"DelayReport",tCube)

        // Add custom actions to generated dashboard
        Set tSC=##class(%DeepSee.Dashboard.Utils).%DashboardExists("Generated/Samples for "_tCube_".dashboard",.tDashboardId)
        Set tDashboard=##class(%DeepSee.Dashboard.Definition).%OpenId(tDashboardId)
        Set tActions=$LB("PivotToJupyter","PivotToPowerBI")
        Set:tCube="READY2025" tActions=tActions_$lb("Edit")
        Set:tCube="MCOFlightDelays" tActions=tActions_$lb("DelayReport")
        For i=1:1:tDashboard.widgets.Count() {
            Set tWidget=tDashboard.widgets.GetAt(i)
            Set tListingEligible=(tWidget.type="pivot")&&(tWidget.subtype="pivot")
            For j=1:1:$LL(tActions) {
                Set tAction=$LG(tActions,j)
                Set tIDBased=$select(tAction="Edit":1,tAction="DelayReport":1,1:0)
                If tIDBased'=tListingEligible {
                    // Widget type and Action types should match, else skip
                    continue
                }
                Set tControl=##class(%DeepSee.Dashboard.Control).%New()
                Set tControl.action=tCube_":"_tAction
                Set tControl.label=tAction
                Set tControl.type="auto"
                Set tControl.activeWhen=$select(tIDBased:"listingSelected1",1:"")
                Do tWidget.controls.Insert(tControl)
            }
        }
        Set tSC=tDashboard.%Save()

        // Respond with Dashboard name for redirection
        return {"Dashboard":(tDashboard.fullName)}.%ToJSON()
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"errormessage": (ex.AsStatus())}.%ToJSON()
   }
}

ClassMethod MCOFlightDelays() As %DynamicObject
{
    Try {
        // AnalyzeThis: Generate Cube + Dashboard
        Set tSQL="SELECT Date_SQLSafe As ""Date"", Airline, CauseOfDelay, DelayDuration FROM SampleTables.MCOFlightDelays"
        Set tLines=20000
        Set tCube="MCOFlightDelays"
        Set tSC=##class(AnalyzeThis.Utils).SQLToJSON(tSQL,.tPropertyJSONStreamId,.tDataJSONStreamId)
        Set tSC=##class(AnalyzeThis.Generator).GenerateAll("SQL",tSQL,tLines,,tCube,tPropertyJSONStreamId,tDataJSONStreamId)

        // CustomCubeActionManager: Register new cube for use + Assign custom actions
        Do ##class(CustomCubeActions.Utils).GenerateActionClass(tCube)
        Do ##class(CustomCubeActions.Utils).UpdateActionClass(tCube,"CustomCubeActions.ActionClass."_tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToJupyter","PivotToJupyter.CustomKPIAction","%OnDashboardAction",tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToPowerBI","PivotToPowerBI.CustomKPIAction","%OnDashboardAction",tCube)


        // Add custom actions to generated dashboard
        Set tSC=##class(%DeepSee.Dashboard.Utils).%DashboardExists("Generated/Samples for MCOFlightDelays.dashboard",.tDashboardId)
        Set tDashboard=##class(%DeepSee.Dashboard.Definition).%OpenId(tDashboardId)
        Set tActions=$LB("PivotToJupyter","PivotToPowerBI")
        For i=1:1:tDashboard.widgets.Count() {
            Set tWidget=tDashboard.widgets.GetAt(i)
            For j=1:1:$LL(tActions) {
                Set tControl=##class(%DeepSee.Dashboard.Control).%New()
                Set tControl.action=tCube_":"_$LG(tActions,j)
                Set tControl.label=$LG(tActions,j)
                Set tControl.type="auto"
                Do tWidget.controls.Insert(tControl)
            }
        }
        Set tSC=tDashboard.%Save()

        // Respond with Dashboard name for redirection
        return {"Dashboard":(tDashboard.fullName)}.%ToJSON()
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"errormessage": (ex.AsStatus())}.%ToJSON()
   }
}

ClassMethod PatientConditions() As %DynamicObject
{
    Try {
        // AnalyzeThis: Generate Cube + Dashboard
        Set tSQL="SELECT MRN, BirthDate, Country, City, Condition FROM SampleTables.PatientConditions"
        Set tLines=10001
        Set tCube="PatientConditions"
        Set tSC=##class(AnalyzeThis.Utils).SQLToJSON(tSQL,.tPropertyJSONStreamId,.tDataJSONStreamId)
        Set tSC=##class(AnalyzeThis.Generator).GenerateAll("SQL",tSQL,tLines,,tCube,tPropertyJSONStreamId,tDataJSONStreamId)

        // CustomCubeActionManager: Register new cube for use + Assign custom actions
        Do ##class(CustomCubeActions.Utils).GenerateActionClass(tCube)
        Do ##class(CustomCubeActions.Utils).UpdateActionClass(tCube,"CustomCubeActions.ActionClass."_tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToJupyter","PivotToJupyter.CustomKPIAction","%OnDashboardAction",tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToPowerBI","PivotToPowerBI.CustomKPIAction","%OnDashboardAction",tCube)


        // Add custom actions to generated dashboard
        Set tSC=##class(%DeepSee.Dashboard.Utils).%DashboardExists("Generated/Samples for PatientConditions.dashboard",.tDashboardId)
        Set tDashboard=##class(%DeepSee.Dashboard.Definition).%OpenId(tDashboardId)
        Set tActions=$LB("PivotToJupyter","PivotToPowerBI")
        For i=1:1:tDashboard.widgets.Count() {
            Set tWidget=tDashboard.widgets.GetAt(i)
            For j=1:1:$LL(tActions) {
                Set tControl=##class(%DeepSee.Dashboard.Control).%New()
                Set tControl.action=tCube_":"_$LG(tActions,j)
                Set tControl.label=$LG(tActions,j)
                Set tControl.type="auto"
                Do tWidget.controls.Insert(tControl)
            }
        }
        Set tSC=tDashboard.%Save()

        // Respond with Dashboard name for redirection
        return {"Dashboard":(tDashboard.fullName)}.%ToJSON()
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"errormessage": (ex.AsStatus())}.%ToJSON()
   }
}

ClassMethod READY2025() As %DynamicObject
{
    Try {
        // AnalyzeThis: Generate Cube + Dashboard
        Set tSQL="SELECT FirstName, Level_SQLSafe As ""Level"", Role_SQLSafe As ""Role"", Country, RegistrationDate, PreviousSummits FROM SampleTables.READY2025"
        Set tLines=10001
        Set tCube="READY2025"
        Set tSC=##class(AnalyzeThis.Utils).SQLToJSON(tSQL,.tPropertyJSONStreamId,.tDataJSONStreamId)
        Set tSC=##class(AnalyzeThis.Generator).GenerateAll("SQL",tSQL,tLines,,tCube,tPropertyJSONStreamId,tDataJSONStreamId)

        // CustomCubeActionManager: Register new cube for use + Assign custom actions
        Do ##class(CustomCubeActions.Utils).GenerateActionClass(tCube)
        Do ##class(CustomCubeActions.Utils).UpdateActionClass(tCube,"CustomCubeActions.ActionClass."_tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToJupyter","PivotToJupyter.CustomKPIAction","%OnDashboardAction",tCube)
        Do ##class(CustomCubeActions.Actions).AddAction("PivotToPowerBI","PivotToPowerBI.CustomKPIAction","%OnDashboardAction",tCube)


        // Add custom actions to generated dashboard
        Set tSC=##class(%DeepSee.Dashboard.Utils).%DashboardExists("Generated/Samples for READY2025.dashboard",.tDashboardId)
        Set tDashboard=##class(%DeepSee.Dashboard.Definition).%OpenId(tDashboardId)
        Set tActions=$LB("PivotToJupyter","PivotToPowerBI")
        For i=1:1:tDashboard.widgets.Count() {
            Set tWidget=tDashboard.widgets.GetAt(i)
            For j=1:1:$LL(tActions) {
                Set tControl=##class(%DeepSee.Dashboard.Control).%New()
                Set tControl.action=tCube_":"_$LG(tActions,j)
                Set tControl.label=$LG(tActions,j)
                Set tControl.type="auto"
                Do tWidget.controls.Insert(tControl)
            }
        }
        Set tSC=tDashboard.%Save()

        // Respond with Dashboard name for redirection
        return {"Dashboard":(tDashboard.fullName)}.%ToJSON()
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"errormessage": (ex.AsStatus())}.%ToJSON()
   }
}

ClassMethod FetchData(pName, pID) As %DynamicObject
{
    Try {
        Set tJSONData=""
        If pName="READY2025" {
            Set tJSONData=##class(SampleTables.READY2025).FetchData(pID)
        } ElseIf pName="MCOFlightDelays" {
            Set tJSONData=##class(SampleTables.MCOFlightDelays).FetchData(pID)
        } Else {
            &sql(SELECT JSON_OBJECT('MRN':MRN, 'BirthDate':BirthDate, 'Country':Country, 'City':City, 'Condition':Condition) INTO :tJSONData FROM SampleTables.PatientConditions WHERE %ID=:pID)
        }
    } Catch (ex) {
        Do ##class(%REST.Impl).%SetStatusCode("500")
        return {"errormessage": (ex.AsStatus())}.%ToJSON()
    }

    Return tJSONData
}

}
