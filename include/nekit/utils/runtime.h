// MIT License

// Copyright (c) 2017 Zhuhao Wang

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#pragma once

#include <boost/asio.hpp>
#include <boost/noncopyable.hpp>

#include "../instance.h"
#include "../rule/rule_set.h"
#include "resolver_interface.h"

namespace nekit {
namespace utils {
class Runtime : private boost::noncopyable {
 public:
  static Runtime& CurrentRuntime();

  rule::RuleSet* RuleSet();
  utils::ResolverInterface* Resolver();
  boost::asio::io_service* IoService();

  friend class nekit::Instance;

 private:
  void SetRuleSet(rule::RuleSet* rule_set);
  void SetResolver(utils::ResolverInterface* resolver);
  void SetIoService(boost::asio::io_service* io);

  rule::RuleSet* rule_set_;
  utils::ResolverInterface* resolver_;
  boost::asio::io_service* io_;
};
}  // namespace utils
}  // namespace nekit