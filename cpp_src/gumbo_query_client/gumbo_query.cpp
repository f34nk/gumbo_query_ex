// #include <iostream>
#include <string>
#include "erl_interface.h"
#include "ei.h"
#include "Document.h"
#include "Node.h"

#include "gumbo_query.h"

const std::string gumbo_query::find(const std::string html, const std::string selector){
  std::string page(html);
  CDocument doc;
  doc.parse(page.c_str());

  CSelection c = doc.find(selector);
  return c.nodeAt(0).text();
}