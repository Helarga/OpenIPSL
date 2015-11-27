within iPSL.Electrical.Machines.PSAT.SixthOrder;
model Order6
  import Modelica.Constants.pi;
  extends BaseClasses.baseMachine(
  delta(start=delta0),
  pe(start=pm00),
  pm(start=pm00),
  pm0(start = pm00),
  vf(start=vf00),
  vf0(start=vf00),
  vq(start=vq0),
  vd(start=vd0),
  iq(start=iq0),
  id(start=id0));

  parameter Real xd=1.9 "d-axis synchronous reactance (pu)"
                                                           annotation(Dialog(group="Machine parameters"));
  parameter Real xq=1.7 "q-axis synchronous reactance (pu)"
                                                           annotation(Dialog(group="Machine parameters"));
  parameter Real xq1=0.5 "q-axis transient reactance (pu)"
                                                          annotation(Dialog(group="Machine parameters"));
  parameter Real xd2=0.204 "d-axis sub-transient reactance (pu)"
                                                                annotation(Dialog(group="Machine parameters"));
  parameter Real xq2=0.3 "q-axis sub-transient reactance (pu)"
                                                              annotation(Dialog(group="Machine parameters"));
  parameter Real Td10=8 "d-axis open circuit transient time constant (s)"
                                                                         annotation(Dialog(group="Machine parameters"));
  parameter Real Tq10=0.8 "q-axis open circuit transient time constant (s)" annotation(Dialog(group="Machine parameters"));
  parameter Real Td20=0.04 "d-axis open circuit transient time constant (s)" annotation(Dialog(group="Machine parameters"));
  parameter Real Tq20=0.02 "q-axis open circuit transient time constant (s)"
                                                                            annotation(Dialog(group="Machine parameters"));
  parameter Real Taa=2e-3 "d-axis aditional leakage time constant (s)"
                                                                      annotation(Dialog(group="Machine parameters"));

protected
  parameter Real Xd = xd * CoB "d-axis reactance, p.u.";
  parameter Real x2d = xd2 * CoB
    "d-axis sub-transient reactance, p.u.(only for V.2,VI,VIII)";
  parameter Real Xq = xq * CoB "q-axis reactance, p.u.";
  parameter Real x1q = xq1 * CoB "q-axis reactance, p.u.";
  parameter Real x2q = xq2 * CoB
    "q-axis sub-trasient reactance, p.u.(only for V.2,VI,VIII)";

  parameter Real delta0 = atan2(vi0 + Ra * ii0 + Xq * ir0, vr0 + Ra * ir0 - Xq * ii0)
    "Initialitation";
  parameter Real vd0 = vr0 * cos(pi / 2 - delta0) - vi0 * sin(pi / 2 - delta0)
    "Initialitation";
  parameter Real vq0 = vr0 * sin(pi / 2 - delta0) + vi0 * cos(pi / 2 - delta0)
    "Initialitation";
  parameter Real id0 = ir0 * cos(pi / 2 - delta0) - ii0 * sin(pi / 2 - delta0)
    "Initialitation";
  parameter Real iq0 = ir0 * sin(pi / 2 - delta0) + ii0 * cos(pi / 2 - delta0)
    "Initialitation";
  parameter Real pm00 = (vq0 + Ra * iq0) * iq0 + (vd0 + Ra * id0) * id0
    "Initialitation";
  parameter Real e2q0 = vq0 + Ra * iq0 + x2d * id0 "Initialitation";
  parameter Real e2d0 = vd0 + Ra * id0 - x2q * iq0 "Initialitation";
  parameter Real e1d0 = (Xq - x1q - Tq20/Tq10*x2q/x1q*(Xq - x1q))*iq0;
  parameter Real K1=(Xd - x1d - Td20 / Td10 * x2d / x1d * (Xd - x1d));
  parameter Real K2=(x1d - x2d + Td20 / Td10 * x2d / x1d * (Xd - x1d));
  parameter Real e1q0 = e2q0 + K2 * id0 - Taa/Td10 *((K1+K2)*id0+e2q0);
  parameter Real vf00= (K1*id0+e1q0)/(1-Taa/Td10);
public
  Real e1q(start = e1q0) "q-axis transient voltage";
  Real e1d(start = e1d0) "d-axis transient voltage";
  Real e2q(start = e2q0) "q-axis sub-transient voltage";
  Real e2d(start = e2d0) "d-axis sub-transient voltage";
equation
  der(e1q) = ((-e1q) - (Xd - x1d - Td20 / Td10 * x2d / x1d * (Xd - x1d)) * id + (1 - Taa / Td10) * vf) / Td10;
  der(e1d) = ((-e1d) + (Xq - x1q - Tq20 / Tq10 * x2q / x1q * (Xq - x1q)) * iq) / Tq10;
  der(e2d) = ((-e2d) + e1d + (x1q - x2q + Tq20 / Tq10 * x2q / x1q * (Xq - x1q)) * iq) / Tq20;
  der(e2q) = ((-e2q) + e1q - (x1d - x2d + Td20 / Td10 * x2d / x1d * (Xd - x1d)) * id + Taa / Td10 * vf) / Td20
    "differential equations";
  e2q = vq + Ra * iq + x2d * id;
  e2d = vd + Ra * id - x2q * iq;
  pm0=pm00;
  vf0 = vf00;
 annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {10, 10}), graphics={  Rectangle(visible=  true, fillColor=  {255, 255, 255}, extent=  {{-100.0, -100.0}, {100.0, 100.0}}),
                                                                                          Text(                origin={4,
              61.9022},
            fillPattern=FillPattern.Solid,                                                                                                    extent=  {{-57.2101, -15.0}, {57.2101, 15.0}},                       fontName=
              "Arial",
          lineColor={28,108,200},
          textString="Order VI")}),                                                                                                    Diagram(coordinateSystem(extent={{-148.5,
            -105},{148.5,105}},                                                                                                    preserveAspectRatio=false,  initialScale = 0.1, grid = {5, 5})),
    Documentation(info="<html>
<table cellspacing=\"1\" cellpadding=\"1\" border=\"1\">
<tr>
<td><p>Reference</p></td>
<td>Generator Order VI, PSAT Manual</td>
</tr>
<tr>
<td><p>Last update</p></td>
<td>2015-10-02</td>
</tr>
<tr>
<td><p>Author</p></td>
<td><p>Le Qi, SmarTS Lab, KTH Royal Institute of Technology</p></td>
</tr>
<tr>
<td><p>Contact</p></td>
<td><p><a href=\"mailto:luigiv@kth.se\">luigiv@kth.se</a></p></td>
</tr>
</table>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">&LT;iPSL: iTesla Power System Library&GT;</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Copyright 2015 RTE (France), AIA (Spain), KTH (Sweden) and DTU (Denmark)</span></p>
<ul>
<li><span style=\"font-family: MS Shell Dlg 2;\">RTE: http://www.rte-france.com/ </span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">AIA: http://www.aia.es/en/energy/</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">KTH: https://www.kth.se/en</span></li>
<li><span style=\"font-family: MS Shell Dlg 2;\">DTU:http://www.dtu.dk/english</span></li>
</ul>
<p><span style=\"font-family: MS Shell Dlg 2;\">The authors can be contacted by email: info at itesla-ipsl dot org</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This package is part of the iTesla Power System Library (&QUOT;iPSL&QUOT;) .</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The iPSL is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">You should have received a copy of the GNU Lesser General Public License along with the iPSL. If not, see &LT;http://www.gnu.org/licenses/&GT;.</span></p>
</html>"));
end Order6;
