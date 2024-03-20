
## Description

These resources is needed to support mounting HostPath on Puree cluster using VESSL AI.
VESSL AI uses `Directory` instead of `DirectoryOrCreate` for HostPath, so it doesn't work when the specified directory not exist.