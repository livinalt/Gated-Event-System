import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const GatedEventModule = buildModule("GatedEventModule", (m) => {

  const ownerAddress = "";
  
  const gatedEvent = m.contract("GateEvent", [ownerAddress]);

  return { gatedEvent };
});

export default GatedEventModule;
