import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const GateTokenModule = buildModule("GateTokenModule", (m) => {

  const ownerAddress = "";
  
  const gateToken = m.contract("GateToken", [ownerAddress]);

  return { gateToken };
});

export default GateTokenModule;
