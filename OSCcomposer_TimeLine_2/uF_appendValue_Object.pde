private Object[] appendValue(Object[] obj, Object newObj) {

  ArrayList<Object> temp = new ArrayList<Object>(Arrays.asList(obj));
  temp.add(newObj);
  return temp.toArray();
}


