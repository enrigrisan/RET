% returns the rotation orthogonal matrix (det=1) for angle of rotation a

function rm=rotmatrix(a);
rm=[cos(a),sin(a);-sin(a),cos(a)];
