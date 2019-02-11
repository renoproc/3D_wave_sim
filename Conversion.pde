/**
 Cartesian <--> Spherical conversion methods about any origin.

 In the methods below :
 All angles are in radians.
 The PVector xyz represents the cartsian coordinates [x, y, z]
 The PVector rtp represents the spherical coordinates [radius, theta, phi]
 ou encore [rayon,latitude,longitude]

 The methods are designed to avoid unneccesasry PVector object creation 
 for efficiancy reasons.

 These methods use the float datatype throughout so there will be some 
 rounding errors but will still be accurate to 7 significant digits. This
 will have no visible effect in the vast majority of sketches so is no 
 cause for concern.

 created by Quark 2018
**/

/**
 Convert a set of cartesian coordinates to spherical coordinates.
 The cartesian coordinates are about the origin [0,0,0] unless 
 another origin is specified.

 @ param xyz cartesian coordinates to convert
 @ param rtp PVector to hold caculated spherical coordinates (optional)
 @ param origin the xyz coordinates origin in 3D space (optional)
 @ return a PVector holding the spherical coordinates
 */
PVector cartesianToSpherical(PVector xyz, PVector rtp, PVector origin) {
  // Create a new PVector only if the user has not provided one
  if (rtp == null) {
    rtp = new PVector();
  }
  // In most cases the origin will be [0,0,0] this avoids the need to create a
  // PVector when an origin is not provided
  float ox = xyz.x, oy = xyz.y, oz = xyz.z;
  if (origin != null) {
    ox -= origin.x;
    oy -= origin.y;
    oz -= origin.z;
  }
  float rad = sqrt(ox*ox + oy*oy + oz*oz);
  if (rad != 0) {
    rtp.x = rad;
    rtp.y = atan2(oy, ox);
    rtp.z = acos(oz / rad);
  }
  return rtp;
}

/**
 Convert a set of spherical coordinates to cartesian coordinates.
 The spherical coordinates are about the origin [0,0,0] unless 
 another origin is specified.

 @ param rtp spherical coordinates to convert
 @ param xyz PVector to hold caculated cartesian coordinates (optional)
 @ param origin the xyz coordinates origin in 3D space (optional)
 @ return a PVector holding the cartesian coordinates
 */
PVector sphericalToCartesian(PVector rtp, PVector xyz, PVector origin) {
  // Create a new PVector only if the user has not provided one
  if (xyz == null) {
    xyz = new PVector();
  }
  // In most cases the origin will be [0,0,0] this avoids the need to create a
  // PVector when an origin is not provided
  float ox=0, oy=0, oz=0;
  if (origin != null) {
    ox = origin.x;
    oy = origin.y;
    oz = origin.z;
  }
  float sin_p = sin(rtp.z);
  xyz.x = rtp.x * cos(rtp.y) * sin_p + ox;
  xyz.y = rtp.x * sin(rtp.y) * sin_p + oy;
  xyz.z = rtp.x * cos(rtp.z) + oz;
  return xyz;
}
