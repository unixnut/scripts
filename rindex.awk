function rindex( str, search,     pos, res )
{
  do 
  {
    res = index( substr( str, pos + 1 ), search );
    pos += res;
  } while (res >= 1); 
  return pos;
}
