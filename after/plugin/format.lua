function endsWith(str, suffix)
  return str:match(suffix .. "$") ~= nil
end
