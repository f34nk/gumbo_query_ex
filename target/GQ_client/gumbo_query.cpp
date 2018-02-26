// #include <iostream>
// #include <sstream>
#include <fstream>
#include <string>
// #include <vector>
// #include "erl_interface.h"
// #include "ei.h"
#include "Document.hpp"
#include "Selection.hpp"
#include "Node.hpp"

#include "gumbo_query.h"
#include "gumbo.h"

using namespace gq;

// static std::string& implode(const std::vector<std::string>& elems, char delim, std::string& s)
// {
//     for (std::vector<std::string>::const_iterator ii = elems.begin(); ii != elems.end(); ++ii)
//     {
//         s += (*ii);
//         if ( ii + 1 != elems.end() ) {
//             s += delim;
//         }
//     }

//     return s;
// }

// static std::string implode(const std::vector<std::string>& elems, char delim)
// {
//     std::string s;
//     return implode(elems, delim, s);
// }

// const std::string gumbo_query::find(const std::string& html, const std::string& selector){
//   auto doc = gq::Document::Create();
//   doc->Parse(html);
//   return doc->GetOuterHtml();
// }

// const std::string gumbo_query::find(const std::string& html, const std::string& selector){
//   std::string page(html);
//   GumboOptions options = kGumboDefaultOptions;
//   GumboOutput* output = gumbo_parse_with_options(&options, page.data(), page.length());
//   auto doc = gq::Document::Create(output);
//   return doc->GetOuterHtml();
// }

// repos/gumbo_query_ex/target/gumbo-parser/examples/serialize.cc
const std::string gumbo_query::find(const std::string& html, const std::string& selector){

  std::string page(html);

  // page.resize(200);
  // throw std::runtime_error(page.c_str());

  GumboOptions options = kGumboDefaultOptions;
  GumboOutput* output = gumbo_parse_with_options(&options, page.data(), page.size());

  auto doc = gq::Document::Create(output);
  // doc->Parse(html);
  // return doc->GetOuterHtml();
  Selection results = doc->Find(selector);
  int numResults = results.GetNodeCount();
  std::stringstream result;
  for(int i = 0; i < numResults; i++){
    const Node* node = results.GetNodeAt(i);
    result << node->GetOuterHtml();
  }
  return result.str();
}

//repos/gumbo_query_ex/target/GQ/ide/msvc/TestParser/TestParser.cpp
// const std::string gumbo_query::find(const std::string html, const std::string selector){

//   std::ofstream out("tmp.txt");
//   out << html;
//   out.close();

//   std::ifstream htmlFile("tmp.txt", std::ios::binary | std::ios::in);

//   std::string testHtmlContents;
//   htmlFile.seekg(0, std::ios::end);

//   auto phfsize = htmlFile.tellg();

//   testHtmlContents.resize(static_cast<size_t>(phfsize));
//   htmlFile.seekg(0, std::ios::beg);
//   htmlFile.read(&testHtmlContents[0], testHtmlContents.size());
//   htmlFile.close();

//   auto doc = gq::Document::Create();
//   doc->Parse(testHtmlContents);

//   Selection results = doc->Find(selector);
//   int numResults = results.GetNodeCount();
//   std::stringstream result;
//   for(int i = 0; i < numResults; i++){
//     const Node* node = results.GetNodeAt(i);
//     result << node->GetOuterHtml();
//   }
//   return result.str();
// }

// const std::string gumbo_query::find(const std::string html, const std::string selector){
//   auto doc = gq::Document::Create();
//   doc->Parse(html);
//   // return doc->GetOuterHtml();
//   // try
//   // {
//     Selection results = doc->Find(selector);
//     int numResults = results.GetNodeCount();
//     std::stringstream result;
//     for(int i = 0; i < numResults; i++){
//       const Node* node = results.GetNodeAt(i);
//       result << node->GetOuterHtml();
//     }
//     return result.str();
//   // }
//   // catch(std::runtime_error& e)
//   // {
//   //   // Necessary because naturally, the parser can throw.
//   //   return "error";
//   // }
// }
