module Daffy.Command
  ( Command(..)
  , render
  ) where

import Data.Aeson (FromJSON)

data Command = Command
  { command :: String -- ^ Raw shell command. Invariant: non-empty.
  , stats :: Bool
  , eventlog :: Bool
  } deriving (Generic)

instance FromJSON Command

-- | Render a 'Command' as a full shell command including all RTS opts.
render :: FilePath -> Command -> String
render statsfile cmd =
  concat
    [ command cmd
    , " +RTS"
    , if stats cmd
        then " -S" ++ statsfile
        else ""
    , if eventlog cmd
        then " -l"
        else ""
    ]