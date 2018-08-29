"""
Spikes

Includes types and methods for handling spike trains.
"""
module Spikes

using JLD
import Base: show, isequal, hash
include("metadata.jl")

################################################################################
#### Include appropriate files
################################################################################
include("SpikeTrains.jl")
include("poissonproc.jl")
include("fileio.jl")
# include("CRCNS/CRCNS.jl")

################################################################################
#### Miscellaneous functions and constants
################################################################################

export show, isequal, hash, savespikes, loadspikes,
       SpikeTrains, histogram, raster, n_cells,
       inhomogeneous_poisson_process

end #module
