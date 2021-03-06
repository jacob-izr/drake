function [qrot, dqrot] = rotmat2Representation(rotation_type, R, dR)
% Convert from rotation matrix representation to a differen representation
% of orientation, as specified by the argument \p rotation_type
% Front-end for the various rotmat2* functions
%
% @param rotation_type 0: no rotation, just return zeros \n
%                      1: rpy representation \n
%                      2: quaternion representation
% @param R rotation matrix
% @param dR gradient of R with respect to a coordinate vector q
%
% @retval qrot representation of orientation described by R in format
% described by \p rotation_type
% @retval dqrot gradient of qrot with respect to R

compute_gradient = nargout > 1;

switch rotation_type
  case 0
    qrot = zeros(0, 1);
    if compute_gradient
      dqrot = zeros(numel(qrot), size(dR, 2));
    end
  case 1
    if compute_gradient
      [qrot, dqrot] = rotmat2rpy(R, dR);
    else
      qrot = rotmat2rpy(R);
    end
  case  2
    if compute_gradient
      [qrot, dqrot] = rotmat2quat(R, dR);
    else
      qrot = rotmat2quat(R);
    end
  otherwise
    error('rotation type not recognized');
end
end