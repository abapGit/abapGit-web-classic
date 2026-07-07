import express from "express";
import { initializeABAP } from "../output/init.mjs";
import { cl_express_icf_shim } from "../output/cl_express_icf_shim.clas.mjs";

await initializeABAP();

const app = express();
const port = Number(process.env.PORT || 3000);
const base = process.env.ICF_BASE || "/sap/abapgit";

app.use(express.raw({ type: "*/*" }));

app.all([base, `${base}*`], async (req, res, next) => {
  try {
    await cl_express_icf_shim.run({
      req,
      res,
      base,
      class: "ZCL_ABAPGIT_WEB_SICF",
    });
  } catch (error) {
    next(error);
  }
});

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}${base}`);
});
