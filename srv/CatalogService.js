
module.exports  = cds.service.impl( async function(){

    //Get object of entities
    const { EmployeeSet, POSet } = this.entities;

    this.before('UPDATE',EmployeeSet,(req)=>{
        var salary = parseFloat(req.data.salaryAmount);
        if(salary >= 1000000){
            req.error(500,'Oops!! you are not allowed to enter this much salary');
        }
    });

    this.after('READ',EmployeeSet,(data)=>{
        data.push({
            "ID":"Dummy",
            "nameFirst":"DummyDeepak"
        })
    });

    this.on('getDefaultPO',async (req,res) => {
        return {
            "OVERALL_STATUS": "N"
        }
    })

    this.on('boost',async function(req,res){
        try {
            //Since its instance bound will get key of PO
            const ID = req.params[0];
            //print on console
            console.log("Hey Amigo, Your PO id " + ID.NODE_KEY );
            //start db transaction using cds ql https://cap.cloud.sap/docs/node.js/cds-ql
            const tx = cds.tx(req);
            //update db - set amount = current + 20000
            await tx.update(POSet).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(ID);
        } catch (error) {
            return "Error: "+ error.toString();
        }
    })

    this.on('largestOrder', async function(req,res){
        try {
            const tx = cds.tx(req);

            //Select * UPTO 1 rows ORDER by GROSS_AMOUNT desc
            // const PO = await tx.read(POSet).orderBy({
            //     GROSS_AMOUNT: 'desc'
            // }).limit(1);

            const PO = await tx.run( SELECT.from(POSet).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(1) )

            return PO;
        } catch (error) {
            return "Error " + error.toString();  
        }

    })

});