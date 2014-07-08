---
layout: post
title: "Helpful error messages"
modified: 2014-07-08 22:22:48 +0800
tags: [programming,c++,boost]
image:
  feature: hands-up.jpg
  credit:  Unknown
  creditlink: 
comments: true 
share: true
---
As I've mentioned before, I've been taking some classes on modern C++11. One of the other classes offered is an introduction to the Boost library.
That's what I've been busy with the last two days. The library is pretty good, but some of the error messages could be more helpful. Behold:

{% highlight C++ %}
/usr/include/boost/units/detail/conversion_impl.hpp:345:102: error: no matching function
for call to ‘conversion_factor(boost::units::unit<boost::units::list<boost::units::dim
<boost::units::length_base_dimension, boost::units::static_rational<1l> >, boost::units::
list<boost::units::dim<boost::units::time_base_dimension, boost::units::static_rational
<-2l> >, boost::units::dimensionless_type> >, boost::units::heterogeneous_system<boost::
units::heterogeneous_system_impl<boost::units::list<boost::units::
heterogeneous_system_dim<boost::units::si::meter_base_unit, boost::units::static_rational
<1l> >, boost::units::list<boost::units::heterogeneous_system_dim<boost::units::si::
second_base_unit, boost::units::static_rational<-2l> >, boost::units::dimensionless_type>
>, boost::units::list<boost::units::dim<boost::units::length_base_dimension, boost::units
::static_rational<1l> >, boost::units::list<boost::units::dim<boost::units::
time_base_dimension, boost::units::static_rational<-2l> >, boost::units::
dimensionless_type> >, boost::units::list<boost::units::scale_list_dim<boost::units::
scale<10l, boost::units::static_rational<-2l> > >, boost::units::dimensionless_type> > >,
void>&, boost::units::unit<boost::units::list<boost::units::dim<boost::units::
length_base_dimension, boost::units::static_rational<1l> >, boost::units::list<boost::
units::dim<boost::units::time_base_dimension, boost::units::static_rational<-1l> >,
boost::units::dimensionless_type> >, boost::units::homogeneous_system<boost::units::list
<boost::units::si::meter_base_unit, boost::units::list<boost::units::scaled_base_unit
<boost::units::cgs::gram_base_unit, boost::units::scale<10l, boost::units::
static_rational<3l> > >, boost::units::list<boost::units::si::second_base_unit, boost::
units::list<boost::units::si::ampere_base_unit, boost::units::list<boost::units::si::
kelvin_base_unit, boost::units::list<boost::units::si::mole_base_unit, boost::units::list
<boost::units::si::candela_base_unit, boost::units::list<boost::units::angle::
radian_base_unit, boost::units::list<boost::units::angle::steradian_base_unit, boost::
units::dimensionless_type> > > > > > > > > > >&)’
         return(destination_type::from_value(static_cast<T2>(source.value() *
                    conversion_factor(u1, u2))));
{% endhighlight %}

This is the first line of the compilation error you get when you make a type-error using the Units
package, e.g. when doing something like:

{% highlight C++ %}
quantity<si::meters> d(2.0 * si::meters);
quantity<si::time> t(100.0 * si::seconds);

quantity<si::velocity> x(d / t / t);
// quantity<si::velocity> x(d / t);
{% endhighlight %}
