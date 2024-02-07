const cds=require('@sap/cds')
module.exports = cds.service.impl(async function () {
    const { States, BusinessPartner } = this.entities;
    this.on("READ", BusinessPartner, async (req) => {
        const results = await cds.run(req.query);
        return results;
      });
    this.before("CREATE",  BusinessPartner, async (req) => {
        const { partnerno, Isgstnregistered, Gstin } = req.data;
        if (Isgstnregistered && !Gstin) {
            req.error({
                code: "MISSING_GST_NUM",
                message: "GSTIN number is mandatory when Is_gstn_registered is true",
                target: "Gstin",
            });
        }
        const query1 = SELECT.from( BusinessPartner).where({ partnerno: req.data.partnerno });
        const result = await cds.run(query1); // Execute the query using cds.run()
        if (result.length > 0) {
          req.error({
            code: "STEMAILEXISTS",
            message: " already exists",
            target: "partnerno",
          });
        }
        
      });
      this.on('READ',States,async(req)=>{
        states=[
            {"code":"TS","description":"Telangana"},
            {"code":"AP","description":"Andra Pradesh"},
        ]
        states.$count=states.length
        return statess;
    })
})