use_bold()
{
  if [ $colour = y ] ; then
    setterm -bold on
  fi
}


use_normal()
{
  if [ $colour = y ] ; then
    setterm -bold off
  fi
}



