module HW.Handler.Newsletter
  ( newsletterHandler
  )
where

import qualified Data.List
import qualified Data.Map
import qualified Data.Ord
import qualified HW.Handler.Base
import qualified HW.Template.Newsletter
import qualified HW.Type.Config
import qualified HW.Type.Issue
import qualified HW.Type.State
import qualified Network.HTTP.Types
import qualified Network.Wai

newsletterHandler
  :: Applicative m => HW.Type.State.State -> m Network.Wai.Response
newsletterHandler state = do
  let
    baseUrl = HW.Type.Config.configBaseUrl $ HW.Type.State.stateConfig state
    issues =
      Data.List.sortOn (Data.Ord.Down . HW.Type.Issue.issueNumber)
        . Data.Map.elems
        $ HW.Type.State.stateIssues state
  pure
    . HW.Handler.Base.htmlResponse Network.HTTP.Types.ok200 []
    $ HW.Template.Newsletter.newsletterTemplate baseUrl issues
