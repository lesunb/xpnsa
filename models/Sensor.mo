block Sensor
  Modelica.Blocks.Interfaces.RealInput measurement annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-72, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput risk_pct annotation(
    Placement(visible = true, transformation(origin = {90, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Real HighRisk0_lb, HighRisk0_ub;
  parameter Real MidRisk0_lb, MidRisk0_ub;
  parameter Real LowRisk_lb, LowRisk_ub;
  parameter Real MidRisk1_lb, MidRisk1_ub;
  parameter Real HighRisk1_lb, HighRisk1_ub;
  parameter Real LowRisk_lb_pct, LowRisk_ub_pct;
  parameter Real MidRisk0_lb_pct, MidRisk0_ub_pct;
  parameter Real HighRisk0_lb_pct, HighRisk0_ub_pct;
  parameter Real recharge_level = 0.1;
  parameter Integer battery_gain = 40000;
  parameter Real threshold_transfer_failure = 0.1;
  Modelica.Blocks.Interfaces.BooleanOutput sig_collected(start = false) "Boolean variable that changes when a sample is collected" annotation(
    Placement(visible = true, transformation(origin = {110, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput context annotation(
    Placement(visible = true, transformation(origin = {-112, -52}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-69, -53}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler annotation(
    Placement(visible = true, transformation(origin = {-48, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-55, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Frequency annotation(
    Placement(visible = true, transformation(origin = {-110, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-69, -33}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  TriggerToPulse triggerToPulse(Twidth = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-31, -15}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Process process(HighRisk0_lb = HighRisk0_lb, HighRisk0_lb_pct = HighRisk0_lb_pct, HighRisk0_ub = HighRisk0_ub, HighRisk0_ub_pct = HighRisk0_ub_pct, HighRisk1_lb = HighRisk1_lb, HighRisk1_ub = HighRisk1_ub, LowRisk_lb = LowRisk_lb, LowRisk_lb_pct = LowRisk_lb_pct, LowRisk_ub = LowRisk_ub, LowRisk_ub_pct = LowRisk_ub_pct, MidRisk0_lb = MidRisk0_lb, MidRisk0_lb_pct = MidRisk0_lb_pct, MidRisk0_ub = MidRisk0_ub, MidRisk0_ub_pct = MidRisk0_ub_pct, MidRisk1_lb = MidRisk1_lb, MidRisk1_ub = MidRisk1_ub, weight_new_value = 1, weight_old_value = 0)  annotation(
    Placement(visible = true, transformation(origin = {-10, 26}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Battery battery(gain_k = battery_gain, recharge_level = recharge_level)  annotation(
    Placement(visible = true, transformation(origin = {-17, -69}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Modelica.Blocks.Logical.And and11 annotation(
    Placement(visible = true, transformation(origin = {-74, -36}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput Recharge annotation(
    Placement(visible = true, transformation(origin = {16, -100}, extent = {{-12, -12}, {12, 12}}, rotation = 90), iconTransformation(origin = {1.33227e-15, -68}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_battery_on annotation(
    Placement(visible = true, transformation(origin = {-52, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {64, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_processed annotation(
    Placement(visible = true, transformation(origin = {110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -40}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {18, -50}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Logical.Or or11 annotation(
    Placement(visible = true, transformation(origin = {40, -28}, extent = {{-6, -6}, {6, 6}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput sig_transfered annotation(
    Placement(visible = true, transformation(origin = {110, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {64, -32}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.And and12 annotation(
    Placement(visible = true, transformation(origin = {-22, 4}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Logical.And and13 annotation(
    Placement(visible = true, transformation(origin = {12, 20}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  FrequencyTrigger frequencyTrigger annotation(
    Placement(visible = true, transformation(origin = {-77, -15}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  DataTransfer dataTransfer annotation(
    Placement(visible = true, transformation(origin = {34, 22}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler1 annotation(
    Placement(visible = true, transformation(origin = {18, 26}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler21 annotation(
    Placement(visible = true, transformation(origin = {66, 24}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Modelica.Blocks.Logical.And and14 annotation(
    Placement(visible = true, transformation(origin = {58, 20}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler11 annotation(
    Placement(visible = true, transformation(origin = {-24, 26}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Delay delay(delayTime = 0.01)  annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Delay delay1(delayTime = 0.01) annotation(
    Placement(visible = true, transformation(origin = {4, 20}, extent = {{-2, -2}, {2, 2}}, rotation = 0)));
  Delay delay11(delayTime = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-22, -8}, extent = {{-2, -2}, {2, 2}}, rotation = 90)));
equation
  sig_collected = triggerToPulse.y;
  sig_processed = process.sig_processed;
//and13.y;
  sig_transfered = and14.y;
  connect(measurement, triggeredSampler.u) annotation(
    Line(points = {{-120, 0}, {-74, 0}, {-74, 26}, {-60, 26}}, color = {0, 0, 127}));
  connect(and1.y, triggeredSampler.trigger) annotation(
    Line(points = {{-49.5, -15}, {-48, -15}, {-48, 14}}, color = {255, 0, 255}));
  connect(and1.y, triggerToPulse.u) annotation(
    Line(points = {{-49.5, -15}, {-37, -15}}, color = {255, 0, 255}));
  connect(context, and11.u1) annotation(
    Line(points = {{-112, -52}, {-88, -52}, {-88, -36}, {-81, -36}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, and11.u2) annotation(
    Line(points = {{-38, -69}, {-52, -69}, {-52, -49}, {-84.5, -49}, {-84.5, -41}, {-81, -41}}, color = {255, 0, 255}));
  connect(Recharge, battery.recharge) annotation(
    Line(points = {{16, -100}, {16, -72}, {3, -72}}, color = {255, 0, 255}));
  connect(battery.SIG_BATTERY_ON, sig_battery_on) annotation(
    Line(points = {{-38.08, -69}, {-52.08, -69}, {-52.08, -100}}, color = {255, 0, 255}));
  connect(triggerToPulse.y, or1.u2) annotation(
    Line(points = {{-25, -15}, {13, -15}, {13, -43}}, color = {255, 0, 255}));
  connect(or1.y, battery.u) annotation(
    Line(points = {{18, -57}, {18, -66}, {3, -66}}, color = {255, 0, 255}));
  connect(or11.y, or1.u1) annotation(
    Line(points = {{40, -35}, {40, -38}, {18, -38}, {18, -43}}, color = {255, 0, 255}));
  connect(and11.y, and12.u2) annotation(
    Line(points = {{-67, -36}, {-19, -36}, {-19, -1}}, color = {255, 0, 255}));
  connect(and12.y, process.sig_collected) annotation(
    Line(points = {{-22, 8}, {-22, 20}, {-18, 20}}, color = {255, 0, 255}));
  connect(frequencyTrigger.trigger, and1.u1) annotation(
    Line(points = {{-67, -15}, {-61, -15}}, color = {255, 0, 255}));
  connect(and13.y, dataTransfer.signal) annotation(
    Line(points = {{14, 20}, {25, 20}}, color = {255, 0, 255}));
  connect(and11.y, dataTransfer.context) annotation(
    Line(points = {{-67, -36}, {2, -36}, {2, 10}, {14, 10}, {14, 16}, {25, 16}}, color = {255, 0, 255}));
  connect(dataTransfer.sig_transfered, or11.u1) annotation(
    Line(points = {{43, 20}, {46, 20}, {46, -12}, {40, -12}, {40, -20}}, color = {255, 0, 255}));
  connect(process.y, triggeredSampler1.u) annotation(
    Line(points = {{-2, 26}, {16, 26}}, color = {0, 0, 127}));
  connect(triggeredSampler1.y, dataTransfer.input_value) annotation(
    Line(points = {{20, 26}, {25, 26}}, color = {0, 0, 127}));
  connect(Frequency, frequencyTrigger.frequency) annotation(
    Line(points = {{-110, -28}, {-96, -28}, {-96, -15}, {-88, -15}}, color = {0, 0, 127}));
  connect(and11.y, and1.u2) annotation(
    Line(points = {{-67, -36}, {-64, -36}, {-64, -19}, {-61, -19}}, color = {255, 0, 255}));
  connect(and13.y, triggeredSampler1.trigger) annotation(
    Line(points = {{14, 20}, {18, 20}, {18, 24}}, color = {255, 0, 255}));
  connect(and11.y, and13.u2) annotation(
    Line(points = {{-67, -36}, {2, -36}, {2, 18}, {10, 18}}, color = {255, 0, 255}));
  connect(process.sig_processed, or11.u2) annotation(
    Line(points = {{-2, 20}, {0, 20}, {0, -12}, {36, -12}, {36, -20}}, color = {255, 0, 255}));
  connect(dataTransfer.y, triggeredSampler21.u) annotation(
    Line(points = {{42, 24}, {64, 24}}, color = {0, 0, 127}));
  connect(triggeredSampler21.y, risk_pct) annotation(
    Line(points = {{68, 24}, {90, 24}}, color = {0, 0, 127}));
  connect(and14.y, triggeredSampler21.trigger) annotation(
    Line(points = {{60, 20}, {66, 20}, {66, 22}}, color = {255, 0, 255}));
  connect(and11.y, and14.u2) annotation(
    Line(points = {{-68, -36}, {2, -36}, {2, 10}, {54, 10}, {54, 18}, {56, 18}}, color = {255, 0, 255}));
  connect(triggeredSampler11.y, process.u) annotation(
    Line(points = {{-22, 26}, {-18, 26}}, color = {0, 0, 127}));
  connect(and12.y, triggeredSampler11.trigger) annotation(
    Line(points = {{-22, 8}, {-22, 20}, {-24, 20}, {-24, 24}}, color = {255, 0, 255}));
  connect(dataTransfer.sig_transfered, delay.u) annotation(
    Line(points = {{42, 20}, {48, 20}}, color = {255, 0, 255}));
  connect(delay.y, and14.u1) annotation(
    Line(points = {{52, 20}, {56, 20}}, color = {255, 0, 255}));
  connect(triggeredSampler.y, triggeredSampler11.u) annotation(
    Line(points = {{-37, 26}, {-26, 26}}, color = {0, 0, 127}));
  connect(process.sig_processed, delay1.u) annotation(
    Line(points = {{-2, 20}, {2, 20}}, color = {255, 0, 255}));
  connect(delay1.y, and13.u1) annotation(
    Line(points = {{6, 20}, {10, 20}}, color = {255, 0, 255}));
  connect(triggerToPulse.y, delay11.u) annotation(
    Line(points = {{-24, -14}, {-22, -14}, {-22, -10}}, color = {255, 0, 255}));
  connect(delay11.y, and12.u1) annotation(
    Line(points = {{-22, -6}, {-22, 0}}, color = {255, 0, 255}));
protected
  annotation(
    Icon(graphics = {Rectangle(fillColor = {0, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}}), Text(origin = {-2, 2}, rotation = -90, lineColor = {255, 255, 255}, extent = {{52, -20}, {-52, 20}}, textString = "%name")}),
    uses(Modelica(version = "4.0.0")),
    Diagram);
end Sensor;
