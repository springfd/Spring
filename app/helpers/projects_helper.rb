module ProjectsHelper
  def projectKindOptions
    [['自辦計畫', GLOBAL_VAR['project_self']], 
     ['代管計畫', GLOBAL_VAR['project_delegate']]]
  end
end
