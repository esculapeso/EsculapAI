// Copyright (c) 2011-2014 The Bitcoin Core developers
// Copyright (c) 2017-2019 The Raven Core developers
// Copyright (c) 2020-2021 The ESA Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef ESA_QT_ESAADDRESSVALIDATOR_H
#define ESA_QT_ESAADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class EsaAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit EsaAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** esa address widget validator, checks for a valid esa address.
 */
class EsaAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit EsaAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // ESA_QT_ESAADDRESSVALIDATOR_H
