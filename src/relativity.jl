module SfRelativity

using PhysicalConstants.CODATA2018: c_0, g_n, G
using Unitful
using UnitfulAstro

using ..SfUnits

import ..SfPhysics: kinetic_energy

export lorentz_factor, lorentz_velocity, relativistic_kinetic_energy, relativistic_brachistochrone_transit_time, 
	proper_relativistic_brachistochrone_transit_time, relativistic_velocity, relativistic_delta_v

"""
	lorentz_factor(v::Unitful.Velocity)
	
Compute the Lorentz factor associated with the given velocity.

Note that for small values of `v` floating point precision issues can produce substantial
inaccuracies unless velocities are specified as `BigInt` or `BigFloat`.
"""
lorentz_factor(v::Unitful.Velocity) = 1/sqrt(1-(v/c_0)^2) |> u"m/m"
lorentz_factor(t::Unitful.Time, acc::Unitful.Acceleration) = sqrt(1 + (acc*t/c_0)^2) |> u"m/m"
lorentz_factor(d::Unitful.Length, acc::Unitful.Acceleration) = 1 + (acc * d)/c_0^2 |> u"m/m"

lorentz_velocity(γ) = sqrt(1 - (1/γ)^2) * c_0 |> u"c"

"""
	relativistic_kinetic_energy(m::Unitful.Mass, v::Unitful.Velocity)
	
Compute the kinetic energy of a body with mass `m` travelling at velocity `v`.

Relativistic corrections are included. Note that for small values of `v` floating point precision issues
can produce substantial inaccuracies unless velocities are specified as `BigInt` or `BigFloat`.
"""
relativistic_kinetic_energy(m::SfUnits.Mass, v::Unitful.Velocity) = (m * big(c_0)^2)* (lorentz_factor(v) - 1) |> u"J"

"""
	relativistic_velocity(m::SfUnits.Mass, ke::Unitful.Energy)
	
Velocity of a particle of mass `m` with kinetic energy `ke`, accounting for relativity.
"""
function relativistic_velocity(m::SfUnits.Mass, ke::Unitful.Energy)
	x = 1 + ke / (m * c_0^2)
	return sqrt(c_0^2 - c_0^2 / x^2)
end

function relativistic_brachistochrone_transit_time(dist::Unitful.Length, acc::Unitful.Acceleration)
	hd = dist/2

	2 * sqrt((hd/c_0)^2 + (2 * hd / acc))
end

function proper_relativistic_brachistochrone_transit_time(d::Unitful.Length, acc::Unitful.Acceleration)
	hd = d/2

	2 * (c_0 / acc) * acosh(((acc * hd) / c_0^2) + 1)
end

"""
    relativistic_velocity(t::Unitful.Time, acc::Unitful.Acceleration)
	
Velocity attained by a body undergoing constant acceleration `acc` for time `t`, accounting for relativistic effects.
"""
relativistic_velocity(t::Unitful.Time, acc::Unitful.Acceleration) = (acc*t)/sqrt(1+((acc*t)/c_0)^2|>u"s/s") |>u"m/s"

"""
    relativistic_delta_v(ve::Unitful.Velocity, mr)
	
Delta-V of a rocket with exhaust velocity `ve` and mass ration `mr` accounting for relativistic effects.
"""
relativistic_delta_v(ve::Unitful.Velocity, mr) = c_0 * tanh((ve/c_0) * log(mr)) |>u"m/s"
	
end
