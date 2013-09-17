function RelativeGazeDirConstraintTest(varargin)
  r = RigidBodyManipulator(strcat(getDrakePath(),'/examples/PR2/pr2.urdf'));
  q_nom = zeros(r.getNumDOF(),1);
  constraintTester('RelativeGazeDirConstraintTest', r, @makeCon, @(r) q_nom, @(r) q_nom, varargin{:});
end

function con = makeCon(r)
  bodyA_idx = findLinkInd(r,'r_gripper_palm_link');
  bodyB_idx = findLinkInd(r,'l_gripper_palm_link');
  direction = [1;0;0];
  ax = rand(3,1)-[0;0.5;0.5];
  %x = 1; y = 0; z = 0;
  ax = ax/norm(ax);
  con = RelativeGazeDirConstraint(r,[0 1],bodyA_idx,bodyB_idx,ax,direction,pi,pi/12)
end