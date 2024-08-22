sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ust/deepak/purchaseorderapp/test/integration/FirstJourney',
		'ust/deepak/purchaseorderapp/test/integration/pages/POSetList',
		'ust/deepak/purchaseorderapp/test/integration/pages/POSetObjectPage',
		'ust/deepak/purchaseorderapp/test/integration/pages/POItemSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, POSetList, POSetObjectPage, POItemSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ust/deepak/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOSetList: POSetList,
					onThePOSetObjectPage: POSetObjectPage,
					onThePOItemSetObjectPage: POItemSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);