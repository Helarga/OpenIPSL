within OpenIPSL.Data.PowerPlant.IEEE421.AC;
record AC7B2
  "IEEE421.5 AC7B Type Excitation System Model Data Set 2 (DC Exciter)"
  extends GUDynamicsTemplate;

  replaceable record Machine = MachineData.Machine1   constrainedby
    MachineData.MachineDataTemplate     "Machine data";
  Machine machine;

  replaceable record ExcSystem = ESData.AC.AC7B2   constrainedby
    ESData.AC.ACxBTemplate     "Excitation system data";
  ExcSystem excSystem;

  replaceable record PSS = PSSData.PSS2BND   constrainedby
    PSSData.PSS2BTemplate     "Power system stabilizer data";
  PSS pss;

end AC7B2;
