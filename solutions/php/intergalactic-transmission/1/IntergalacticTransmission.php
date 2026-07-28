<?php

declare(strict_types=1);

function transmitSequence(array $sequence): array
{
    $result = [];
    $acc = 0;
    $accLen = 0;
    foreach ($sequence as $hex) {
        $acc = (($acc << 8) | hexdec($hex)) & 0xffff;
        for ($accLen += 8; $accLen > 7; $accLen -= 7) {
            $bits = ($acc >> ($accLen - 7)) & 0x7f;
            $parity = substr_count(decbin($bits), "1") & 0x01;
            array_push($result, sprintf("0x%02x", ($bits << 1) | $parity));
        }
    }

    if ($accLen > 0) {
        $bits = ($acc << (7 - $accLen)) & 0x7f;
        $parity = substr_count(decbin($bits), "1") & 0x01;
        array_push($result, sprintf("0x%02x", ($bits << 1) | $parity));
    }

    return $result;
}

function decodeMessage(array $message): array
{
    $result = [];
    $acc = 0;
    $accLen = 0;
    foreach ($message as $hex) {
        $byte = hexdec($hex);
        if (substr_count(decbin($byte), "1") & 0x01) {
            throw new Exception("wrong parity");
        }

        $acc = (($acc << 7) | ($byte >> 1)) & 0xffff;
        for ($accLen += 7; $accLen >= 8; $accLen -= 8) {
            array_push($result, sprintf("0x%02x", ($acc >> ($accLen - 8)) & 0xff));
        }
    }

    return $result;
}